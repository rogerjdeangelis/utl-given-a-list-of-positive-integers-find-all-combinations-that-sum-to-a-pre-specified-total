%let pgm=utl-given-a-list-of-positive-integers-find-all-combinations-that-sum-to-a-pre-specified-total;

%stop_submission

Given a of of positive integers find all combinations that sum to a pre specified total

PROBLEM (Identify all the combinations of a, b, c, d values that sum to 21)

SDI.HAVE      |  SD1.WANT (SUM to 21)
              |
              |  COMBINATION_
NUM    VALUES |       ID                IDS            VALUES
              |
 a        1   |  Combination 1    ['a', 'b', 'g']    (1, 3, 17)  = 21
 b        3   |  Combination 2    ['a', 'd', 'f']    (1, 7, 13)  = 21
 c        5   |  Combination 3    ['b', 'c', 'f']    (3, 5, 13)  = 21
 d        7   |  Combination 4    ['b', 'd', 'e']    (3, 7, 11)  = 21
 e       11   |
 f       13   |
 g       17   |


github
https://tinyurl.com/3sy9bm7u
https://github.com/rogerjdeangelis/utl-given-a-list-of-positive-integers-find-all-combinations-that-sum-to-a-pre-specified-total/new/main

communities.sas
https://tinyurl.com/yc4shazj
https://communities.sas.com/t5/Mathematical-Optimization/OptModel-to-find-a-variance-in-a-table/m-p/760505#M3471

SOAPBOX ON

To use and share complex Python data structures,
one often needs to learn the specifics of
Python's
 1 Spcialized data techniques for conversion and manipulation
 2 Interoperability with common basic python statements
 3 Python functions to deal with Python only data structures?

This makes mastering data structures alongside cross-language data exchange
VERY DIFFICULT, especially when working in multi-language environments.

When working with data interchange or hybrid environments like
drop downs to R, Pyhton, SPSS, MATLAB ...,
you often need to convert Python data structures. Unfortunately Pyhon does not provide a way to
convert complex, often nested data structures into ODBC compatible tables.

Python, being a highly flexible and dynamic language, and
offers many data types and complex, often nested data structures (such as lists,
dictionaries, sets, tuples, and custom objects). This richness makes Python very powerful but also
can be challenging, especially when you need to:

 1  Understand and manipulate unfamiliar or deeply nested structures.
 2 Convert these structures into formats compatible with other programming languages or systems.

Many programmers feel like they have to "learn a new
language" just to effectively work with certain Python data structures because the idioms and
manipulation techniques can be VERY DIFFERENT from other languages.

In contrast, R generally
uses fewer core data types and simpler structures (vectors, data frames, lists), which can make it
easier to handle data in some cases, although it has its own complexities.

SAS uses ods and traceing to make it easy to get to onvert sas tables to ODBC compliant structures,
Unfortunately many sas procs cannot create odbc compliant output, ie tabulate, freq(2 or more dimensions),
print and report(close) ...

SOAPBOX OFF


/**************************************************************************************************************************/
/* INPUT                    | PROCESS                                                  | OUTPUT                           */
/* =====                    | =======                                                  | ======                           */
/* SDI.HAVE                 | proc datasets lib=sd1 nolist nodetails;                  | PYTHON                           */
/*                          |  delete pywant;                                          | Comb    IDs           Values     */
/* NUM VALUES               | run;quit;                                                |  1 ['a','b','g'] (1.0,3.0,17.0)  */
/*                          |                                                          |  2 ['a','d','f'] (1.0,7.0,13.0)  */
/*  a     1                 | %utl_pybeginx;                                           |  3 ['b','c','f'] (3.0,5.0,13.0)  */
/*  b     3                 | parmcards4;                                              |  4 ['b','d','e'] (3.0,7.0,11.0)  */
/*  c     5                 | import pandas as pd                                      |                                  */
/*  d     7                 | import itertools                                         | SAS                              */
/*  e    11                 | exec(open('c:/oto/fn_pythonx.py').read());               | COMB    IDS         VALUES       */
/*  f    13                 | df,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');      |                                  */
/*  g    17                 |                                                          |  1 ['a','b','g'] (1.0,3.0,17.0)  */
/*                          | # Extract the values from the 'VAL' column               |  2 ['a','d','f'] (1.0,7.0,13.0)  */
/* options                  | values = df['VAL'].tolist()                              |  3 ['b','c','f'] (3.0,5.0,13.0)  */
/*  validvarname=upcase;;   |                                                          |  4 ['b','d','e'] (3.0,7.0,11.0)  */
/* libname sd1 "d:/sd1";    | # Create a mapping from value to ID                      |                                  */
/* data sd1.have;           | value_to_id={val: id for val                             |                                  */
/*  input id$ val;          |   ,id in zip(df['VAL'], df['ID'])}                       |                                  */
/* cards4;                  |                                                          |                                  */
/* a 1                      | # Find all combinations of values that sum to 21         |                                  */
/* b 3                      | valid_combinations = []                                  |                                  */
/* c 5                      | for r in range(1, len(values) + 1):                      |                                  */
/* d 7                      |     for combo in itertools.combinations(values, r):      |                                  */
/* e 11                     |         if sum(combo) == 21:                             |                                  */
/* f 13                     |             valid_combinations.append(combo)             |                                  */
/* g 17                     | print(valid_combinations)                                |                                  */
/* ;;;;                     |                                                          |                                  */
/* run;quit;                | data = []                                                |                                  */
/*                          |                                                          |                                  */
/*                          | if valid_combinations:                                   |                                  */
/*                          |     for i, combo in enumerate(valid_combinations, 1):    |                                  */
/*                          |         ids = [value_to_id[val] for val in combo]        |                                  */
/*                          |         # Append each combination                        |                                  */
/*                          |         data.append({                                    |                                  */
/*                          |             'Comb': f'{i}',                              |                                  */
/*                          |             'IDs': ids,                                  |                                  */
/*                          |             'Values': combo                              |                                  */
/*                          |         })                                               |                                  */
/*                          |                                                          |                                  */
/*                          |     # Create DataFrame from the collected data           |                                  */
/*                          |     df = pd.DataFrame(data)                              |                                  */
/*                          |     print(df)                                            |                                  */
/*                          |     df.info()                                            |                                  */
/*                          | else:                                                    |                                  */
/*                          |     print("No combinations found that sum to 21.")       |                                  */
/*                          | # Convert the list columns to string representations     |                                  */
/*                          | df['IDs'] = df['IDs'].apply(str)                         |                                  */
/*                          | df['Values'] = df['Values'].apply(str)                   |                                  */
/*                          | print(df);                                               |                                  */
/*                          | fn_tosas9x(df,outlib='d:/sd1/' \                         |                                  */
/*                          |   ,outdsn='pywant',timeest=3);                           |                                  */
/*                          | ;;;;                                                     |                                  */
/*                          | %utl_pyendx;                                             |                                  */
/*                          | proc print data=sd1.pywant;                              |                                  */
/*                          | run;quit;                                                |                                  */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options
 validvarname=upcase;;
libname sd1 "d:/sd1";
data sd1.have;
 input id$ val;
cards4;
a 1
b 3
c 5
d 7
e 11
f 13
g 17
;;;;
run;quit;

/*************************************************************************************************************************/
/*  ID    VAL                                                                                                            */
/*                                                                                                                       */
/*  a       1                                                                                                            */
/*  b       3                                                                                                            */
/*  c       5                                                                                                            */
/*  d       7                                                                                                            */
/*  e      11                                                                                                            */
/*  f      13                                                                                                            */
/*  g      17                                                                                                            */
/*************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
import pandas as pd
import itertools
exec(open('c:/oto/fn_pythonx.py').read());
df,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');

# Extract the values from the 'VAL' column
values = df['VAL'].tolist()

# Create a mapping from value to ID
value_to_id={val: id for val
  ,id in zip(df['VAL'], df['ID'])}

# Find all combinations of values that sum to 21
valid_combinations = []
for r in range(1, len(values) + 1):
    for combo in itertools.combinations(values, r):
        if sum(combo) == 21:
            valid_combinations.append(combo)
print(valid_combinations)

data = []
if valid_combinations:
    for i, combo in enumerate(valid_combinations, 1):
        ids = [value_to_id[val] for val in combo]
        # Append each combination
        data.append({
            'Comb': f'{i}',
            'IDs': ids,
            'Values': combo
        })

    # Create DataFrame from the collected data
    df = pd.DataFrame(data)
    print(df)
    df.info()
else:
    print("No combinations found that sum to 21.")
# Convert the list columns to string representations
df['IDs'] = df['IDs'].apply(str)
df['Values'] = df['Values'].apply(str)
print(df);
fn_tosas9x(df,outlib='d:/sd1/' \
  ,outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;
proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*Python                                      | SAS                                                                       */
/*   Comb              IDs            Values  | COMB          IDS               VALUES                                    */
/*                                            |                                                                           */
/* 0    1  ['a', 'b', 'g']  (1.0, 3.0, 17.0)  |  1      ['a', 'b', 'g']    (1.0, 3.0, 17.0)                               */
/* 1    2  ['a', 'd', 'f']  (1.0, 7.0, 13.0)  |  2      ['a', 'd', 'f']    (1.0, 7.0, 13.0)                               */
/* 2    3  ['b', 'c', 'f']  (3.0, 5.0, 13.0)  |  3      ['b', 'c', 'f']    (3.0, 5.0, 13.0)                               */
/* 3    4  ['b', 'd', 'e']  (3.0, 7.0, 11.0)  |  4      ['b', 'd', 'e']    (3.0, 7.0, 11.0)                               */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
