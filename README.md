# DS-Project


# Purpose

The aim of this folder is to briefly document my work for the data science project due 30 June. 

I will try to build and evaluate models that predict loan defaults 

```{r, echo = FALSE, message = FALSE, warning = FALSE}
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE, fig.width = 6, fig.height = 5)
rm(list = ls()) # Clean your environment:
gc() # garbage collection - It can be useful to call gc after a large object has been removed, as this may prompt R to return memory to the operating system.
library(pacman)
p_load(tidyverse, rmsfuns, 
       readr, # import data
       knitr, # 
       DBI, # interface for SQL
       duckdb, # database backend package
       bigrquery, # alternative database backend package
       raster, # import .asc data
       lubridate # work with dates
       )
# Source in all your functions:
list.files('code/', full.names = T, recursive = T) %>% as.list() %>% walk(~source(.))
```


# Data 

## Import Data


<!-- Data has been saved in local depository in `/data` folder. I import all the .asc files one by one with relevant names. The names are: -->
<!-- ```{r} -->
<!-- data_names <- c(df_account, df_card, df_client,  -->
<!--                 df_disp, df_district, df_loan,  -->
<!--                 df_order, df_trans) -->
<!-- ``` -->

<!-- Import into list -->
<!-- ```{r} -->
<!-- data_list <- as_tibble(list.files('data', full.names = T)) %>%  -->
<!--     filter(grepl(list.files('data', full.names = T), pattern = "asc")) %>%  -->
<!--     as.list() -->



<!-- ``` -->


```{r}
df_account <- read_delim("data/account.csv", delim = ';')
df_card <- read_delim("data/card.csv", delim = ';')
df_client <- read_delim("data/client.csv", delim = ';')
df_disp <- read_delim("data/disp.csv", delim = ';')
df_district <- read_delim("data/district.csv", delim = ';')
df_loan <- read_delim("data/loan.csv", delim = ';')
df_order <- read_delim("data/order.csv", delim = ';')
df_trans <- read_delim("data/trans.csv", delim = ';')
```
### Into Data Base

I use `duckdb` as a backend package that embeds a DuckDB database. 
Open a connection to a database which is stored in memory:

```{r}
con <- dbConnect(duckdb::duckdb(), path = ":memory:")
```

Put data frames into data base `con`
```{r}
# Account
copy_to(
    dest = con, 
    df = df_account, 
    temporary = FALSE
)
# Card
copy_to(
    dest = con, 
    df = df_card, 
    temporary = FALSE
)
# Client
copy_to(
    dest = con, 
    df = df_client, 
    temporary = FALSE
)
# Disp
copy_to(
    dest = con, 
    df = df_disp, 
    temporary = FALSE
)
# District
copy_to(
    dest = con, 
    df = df_district, 
    temporary = FALSE
)
# Loan
copy_to(
    dest = con, 
    df = df_loan, 
    temporary = FALSE
)
# Order 
copy_to(
    dest = con, 
    df = df_order, 
    temporary = FALSE
)
# Trans
copy_to(
    dest = con, 
    df = df_trans, 
    temporary = FALSE
)
```

### Reference to data base

```{r}
db_account <- tbl(con, "df_account")
db_card <- tbl(con, "df_card")
db_client <- tbl(con, "df_client")
db_disp <- tbl(con, "df_disp")
db_district <- tbl(con, "df_district")
db_loan <- tbl(con, "df_loan")
db_order <- tbl(con, "df_order")
db_trans <- tbl(con, "df_trans")
```

## Quick Data EDA

### Loans

The loan status can be found in `db_loan$status`, which gives 4 different classes of loan statuses: *A*, *B*, *C*, and *D*. According to https://github.com/zhouxu-ds/ds-projects/blob/master/loan_default_prediction/data/data_description.pdf the statuses mean the following:

1. **A** - stands for *contract finished, no problems*
2. **B** - stands for *contract finished, loan not payed*
3. **C** - stands for *running contract, OK so far*
4. **D** - stands for *running contract, client in debt*

Therefore, what Zhou Xu does is call A and C *good* and B and D *bad*, putting them into binary classes. 

Create *good* and *bad*:
```{r}
colnames(db_loan)
```

```{r}
df_district <- df_district %>% 
    rename(
    District_Code = A1, 
    District_ID = A2, 
    Region = A3, 
    Inhabitants = A4, 
    VSmall_Municipalities = A5, 
    Small_Municipalities = A6, 
    Medium_Municipatlities = A7, 
    Big_Municipalities = A8, 
    Cities = A9, 
    Urban_Ratio = A10, 
    Salary_Ave = A11, 
    Unemploy_95 = A12, 
    Unemploy_96 = A13, 
    Entrep = A14, 
    Crimes_95 = A15, 
    Crimes_96 = A16
)
```


## Data Decisions

### Account

Date of account creation, as well as the year, month, and day of account creation. It also includes the present day, which is in 1999 and is just assumed to be the first day of the year. 
**Issuance_Freq** gives the frequency with which statements are issued. It is made to be either *monthly*, *weekly*, or *after_transaction*. It may give an indication of how ontop of financial admin the client is

### Client

Year client is born, **Born_Year**
Month and Day the client is born, **Born_Month**, **Born_Day**
Note that the month has +50 if a women, therefore this is used to also create a variable giving gender, *Gender*.
*Age* is 1999 minus *Born_Year*, giving approximate age in years. 

### Disposition
*Owner_Only* is a dummy variable giving a value of 1 if only the owner can control the account - i.e. issue orders and ask for a loan -  and 0 if others can do it. 
I create a variable called *Multiple_Clients* that gives a 1 if there are more than one clients for that particular account and a 0 if not. Then I exclude all duplicate accounts, such that the data set is in terms of its unique account number and the primary client, while indicating whether there are multiple clients that have access. 


### Order

Gives the mean amount that is debited by a specific account number, *Mean_Debited_Order_Amount*.
Gives the modal type of payment made, which can be "Insurance", "Household_Payment", "Leasing", "Loan" (loan repayment), or "other". This variable is called *Modal_Order_Type*. 

### Trans

**exclude missing values** of operation. The rest are recorded in *Transaction_Mode*.

*Trans_Credit* gives the number of credit transactions per account
*Trans_Withdraw* gives the number of withdrawal transactions per account
*Trans_Amount_Mean* gives the mean transaction amount per account
*Trans_Mode* gives the modal transaction mode/type, e.g. "Credit_Card_Withdrawal", "Credit_in_Cash", "Other_Bank", "Cash_Withdrawal". 
*Trans_Balance* gives the mean balance left in the account after a transaction
*Spread* gives the difference between the amount after the transaction and the mean transaction amount. 
*Transaction_Freq* gives the amount of transactions made by a single account . 

### Loan

Note, there are no accounts that have multiple loans:
```{r}
df_loan %>% count(account_id) %>% filter(n>1)
```

**Loan_Year** gives the year the loan is granted
**Loan_Month** gives the month the loan is granted
**Loan_Day** gives the day the loan is granted
**Loan_Date** gives the date the loan is granted
**Default** is a dummy variable indicating whether it is a bad loan (i.e. *Status* B or D)


### District
Just renamed, kept all variables

