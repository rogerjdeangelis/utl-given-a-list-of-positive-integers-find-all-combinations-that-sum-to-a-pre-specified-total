# utl-given-a-list-of-positive-integers-find-all-combinations-that-sum-to-a-pre-specified-total
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


    TWO SOLUTIONS

        1 r itertools combinatio enumeration
        2 sas base barts macros
          Bartosz Jablonski
          yabwon@gmail.com

          SOAPBOX ON
          Examine all arrangements
          upto seven or fewer elements that sum to 21. Your macros can used with other target sums.
          Macros are quite general and should apply to other optimizations.
          I think Bart sorts the input in descending order to asssure he gets all the solutions?
          Sums from most possible elements to fewest?
          It also looks like Barts solution allows us to sample with replcement?
          SOAPBOX ON

        3 another target sums 20
        4 barts macros on end
        5 comments on end

    github
    https://tinyurl.com/3sy9bm7u
    https://github.com/rogerjdeangelis/utl-given-a-list-of-positive-integers-find-all-combinations-that-sum-to-a-pre-specified-total/new/

    SAS-L
    https://mail.google.com/mail/u/0/#inbox/FMfcgzQcpTFXBNHHcBtgbjWKvwRKXlrV

    communities.sas
    https://tinyurl.com/yc4shazj
    https://communities.sas.com/t5/Mathematical-Optimization/OptModel-to-find-a-variance-in-a-table/m-p/760505#M3471


    /**************************************************************************************************************************/
    /* INPUT                    | PROCESS                                                  | OUTPUT                           */
    /* =====                    | =======                                                  | ======                           */
    /* SDI.HAVE                 | 1 R ITERTOOLS ENUMERATION COMBINATION                    | PYTHON                           */
    /*                          | ======================================                   | Comb    IDs           Values     */
    /* NUM VALUES               |                                                          |  1 ['a','b','g'] (1.0,3.0,17.0)  */
    /*                          | proc datasets lib=sd1 nolist nodetails;                  |  2 ['a','d','f'] (1.0,7.0,13.0)  */
    /*  a     1                 |  delete pywant;                                          |  3 ['b','c','f'] (3.0,5.0,13.0)  */
    /*  b     3                 | run;quit;                                                |  4 ['b','d','e'] (3.0,7.0,11.0)  */
    /*  c     5                 |                                                          |                                  */
    /*  d     7                 | %utl_pybeginx;                                           | SAS                              */
    /*  e    11                 | parmcards4;                                              | COMB    IDS         VALUES       */
    /*  f    13                 | import pandas as pd                                      |                                  */
    /*  g    17                 | import itertools                                         |  1 ['a','b','g'] (1.0,3.0,17.0)  */
    /*                          | exec(open('c:/oto/fn_pythonx.py').read());               |  2 ['a','d','f'] (1.0,7.0,13.0)  */
    /* options                  | df,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');      |  3 ['b','c','f'] (3.0,5.0,13.0)  */
    /*  validvarname=upcase;;   |                                                          |  4 ['b','d','e'] (3.0,7.0,11.0)  */
    /* libname sd1 "d:/sd1";    | # Extract the values from the 'VAL' column               |                                  */
    /* data sd1.have;           | values = df['VAL'].tolist()                              |                                  */
    /*  input id$ val;          |                                                          |                                  */
    /* cards4;                  | # Create a mapping from value to ID                      |                                  */
    /* a 1                      | value_to_id={val: id for val                             |                                  */
    /* b 3                      |   ,id in zip(df['VAL'], df['ID'])}                       |                                  */
    /* c 5                      |                                                          |                                  */
    /* d 7                      | # Find all combinations of values that sum to 21         |                                  */
    /* e 11                     | valid_combinations = []                                  |                                  */
    /* f 13                     | for r in range(1, len(values) + 1):                      |                                  */
    /* g 17                     |     for combo in itertools.combinations(values, r):      |                                  */
    /* ;;;;                     |         if sum(combo) == 21:                             |                                  */
    /* run;quit;                |             valid_combinations.append(combo)             |                                  */
    /*                          | print(valid_combinations)                                |                                  */
    /*                          |                                                          |                                  */
    /*                          | data = []                                                |                                  */
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
    /*                          |---------------------------------------------------------------------------------------------*/
    /*                          |                                                          |                                  */
    /*                          | 2 SAS BASE BARTS MACROS                                  |   LIST1    LIST2                 */
    /*                          | =======================                                  |                                  */
    /*                          |                                                          |   G B A    17 3 1  =21           */
    /*                          | proc datasets                                            |   F D A    13 7 1                */
    /*                          | lb=work kill;                                            |   F C B    13 5 3                */
    /*                          | run;quit;                                                |   E D B    11 7 3                */
    /*                          |                                                          |                                  */
    /*                          | data have;                                               |                                  */
    /*                          |  input id$ val;                                          |                                  */
    /*                          | cards4;                                                  |                                  */
    /*                          | a 1                                                      |                                  */
    /*                          | b 3                                                      |                                  */
    /*                          | c 5                                                      |                                  */
    /*                          | d 7                                                      |                                  */
    /*                          | e 11                                                     |                                  */
    /*                          | f 13                                                     |                                  */
    /*                          | g 17                                                     |                                  */
    /*                          | ;;;;                                                     |                                  */
    /*                          | run;quit;                                                |                                  */
    /*                          |                                                          |                                  */
    /*                          | proc sort data=have;                                     |                                  */
    /*                          |   by descending val ;                                    |                                  */
    /*                          | run;                                                     |                                  */
    /*                          |                                                          |                                  */
    /*                          | /*----                                                   |                                  */
    /*                          |  ID    VAL                                               |                                  */
    /*                          |                                                          |                                  */
    /*                          |  g      17                                               |                                  */
    /*                          |  f      13                                               |                                  */
    /*                          |  e      11                                               |                                  */
    /*                          |  d       7                                               |                                  */
    /*                          |  c       5                                               |                                  */
    /*                          |  b       3                                               |                                  */
    /*                          |  a       1                                               |                                  */
    /*                          | ----*/                                                   |                                  */
    /*                          |                                                          |                                  */
    /*                          | proc transpose                                           |                                  */
    /*                          |   data=have                                              |                                  */
    /*                          |   out=t (drop=_:);                                       |                                  */
    /*                          | var val;                                                 |                                  */
    /*                          | id id;                                                   |                                  */
    /*                          | run;                                                     |                                  */
    /*                          |                                                          |                                  */
    /*                          | proc print data=t;                                       |                                  */
    /*                          | run;                                                     |                                  */
    /*                          |                                                          |                                  */
    /*                          | /*----                                                   |                                  */
    /*                          |  G  F  E D C B A                                         |                                  */
    /*                          |                                                          |                                  */
    /*                          | 17 13 11 7 5 3 1                                         |                                  */
    /*                          | ----*/                                                   |                                  */
    /*                          |                                                          |                                  */
    /*                          | %generateCheck(7, 21)                                    |                                  */
    /*                          |                                                          |                                  */
    /*                          |---------------------------------------------------------------------------------------------*/
    /*                          | 3 ANOTHER TARGET SUMS 20                                 |  LIST1      LIST2                */
    /*                          | ========================                                 |                                  */
    /*                          |                                                          |  I A        19 1    =20          */
    /*                          | proc datasets                                            |  F D        13 7                 */
    /*                          | lib=work kill;                                           |  F G        13 7                 */
    /*                          | run;quit;                                                |  F C B      13 5 2               */
    /*                          |                                                          |  E D B      11 7 2               */
    /*                          | /* different case */                                     |  E G B      11 7 2               */
    /*                          | data have;                                               |  D G C A    7 7 5 1              */
    /*                          |  input id$ val;                                          |                                  */
    /*                          | cards4;                                                  |                                  */
    /*                          | a 1                                                      |                                  */
    /*                          | b 2                                                      |                                  */
    /*                          | c 5                                                      |                                  */
    /*                          | d 7                                                      |                                  */
    /*                          | e 11                                                     |                                  */
    /*                          | f 13                                                     |                                  */
    /*                          | g 7                                                      |                                  */
    /*                          | h 21                                                     |                                  */
    /*                          | i 19                                                     |                                  */
    /*                          | ;;;;                                                     |                                  */
    /*                          | run;quit;                                                |                                  */
    /*                          |                                                          |                                  */
    /*                          | proc sort data=have;                                     |                                  */
    /*                          |   by descending val ;                                    |                                  */
    /*                          | run;                                                     |                                  */
    /*                          |                                                          |                                  */
    /*                          | proc transpose                                           |                                  */
    /*                          |   data=have                                              |                                  */
    /*                          |  out=t(drop=_:);                                         |                                  */
    /*                          | var val;                                                 |                                  */
    /*                          | id id;                                                   |                                  */
    /*                          | run;                                                     |                                  */
    /*                          | proc print data=t;                                       |                                  */
    /*                          | run;                                                     |                                  */
    /*                          |                                                          |                                  */
    /*                          | %generateCheck(5, 20)                                    |                                  */
    /*                          |                                                          |                                  */
    /*                          | proc print data=check;                                   |                                  */
    /*                          |                                                          |                                  */
    /*                          |---------------------------------------------------------------------------------------------*/
    /*                          | 4 BARTS MACROS ON END                                    |                                  */
    /*                          | =====================                                    |                                  */
    /*                          | see below                                                |                                  */
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

    /*          _ _            _              _
    / |  _ __  (_) |_ ___ _ __| |_ ___   ___ | |___
    | | | `__| | | __/ _ \ `__| __/ _ \ / _ \| / __|
    | | | |    | | ||  __/ |  | || (_) | (_) | \__ \
    |_| |_|    |_|\__\___|_|   \__\___/ \___/|_|___/
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

    /*___    _                _
    |___ \  | |__   __ _ _ __| |_ ___   _ __ ___   __ _  ___ _ __ ___  ___
      __) | | `_ \ / _` | `__| __/ __| | `_ ` _ \ / _` |/ __| `__/ _ \/ __|
     / __/  | |_) | (_| | |  | |_\__ \ | | | | | | (_| | (__| | | (_) \__ \
    |_____| |_.__/ \__,_|_|   \__|___/ |_| |_| |_|\__,_|\___|_|  \___/|___/
     _ __  _ __ ___   ___ ___  ___ ___
    | `_ \| `__/ _ \ / __/ _ \/ __/ __|
    | |_) | | | (_) | (_|  __/\__ \__ \
    | .__/|_|  \___/ \___\___||___/___/
    |_|
    */

    proc datasets
    lb=work kill;
    run;quit;

    data have;
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

    proc sort data=have;
      by descending val ;
    run;

    /*----
     ID    VAL

     g      17
     f      13
     e      11
     d       7
     c       5
     b       3
     a       1
    ----*/

    proc transpose
      data=have
      out=t (drop=_:);
    var val;
    id id;
    run;

    proc print data=t;
    run;

    /*----
     G  F  E D C B A

    17 13 11 7 5 3 1
    ----*/

    %generateCheck(7, 21)

    proc print data=check;
    run;quit;

    /**************************************************************************************************************************/
    /*  LIST1    LIST2                                                                                                        */
    /*                                                                                                                        */
    /*  G B A    17 3 1                                                                                                       */
    /*  F D A    13 7 1                                                                                                       */
    /*  F C B    13 5 3                                                                                                       */
    /*  E D B    11 7 3                                                                                                       */
    /**************************************************************************************************************************/
    /*____   _                _     _                       _     ____   ___
    |___ /  | |__   __ _ _ __| |_  | |_ __ _ _ __ __ _  ___| |_  |___ \ / _ \
      |_ \  | `_ \ / _` | `__| __| | __/ _` | `__/ _` |/ _ \ __|   __) | | | |
     ___) | | |_) | (_| | |  | |_  | || (_| | | | (_| |  __/ |_   / __/| |_| |
    |____/  |_.__/ \__,_|_|   \__|  \__\__,_|_|  \__, |\___|\__| |_____|\___/
                                                 |___/
    */

    proc datasets
    lib=work kill;
    run;quit;

    /* different case */
    data have;
     input id$ val;
    cards4;
    a 1
    b 2
    c 5
    d 7
    e 11
    f 13
    g 7
    h 21
    i 19
    ;;;;
    run;quit;

    proc sort data=have;
      by descending val ;
    run;

    proc transpose
      data=have
     out=t(drop=_:);
    var val;
    id id;
    run;
    proc print data=t;
    run;

    %generateCheck(5, 20)

    proc print data=check;
    run;quit;

    /**************************************************************************************************************************/
    /* LIST1      LIST2                                                                                                       */
    /*                                                                                                                        */
    /* I A        19 1                                                                                                        */
    /* F D        13 7                                                                                                        */
    /* F G        13 7                                                                                                        */
    /* F C B      13 5 2                                                                                                      */
    /* E D B      11 7 2                                                                                                      */
    /* E G B      11 7 2                                                                                                      */
    /* D G C A    7 7 5 1                                                                                                     */
    /**************************************************************************************************************************/

    filename ft15f001 "c:/oto/chain.sas";
    parmcards4;
    %macro chain(n,arr=x,sep=+,i=i,fn=);
    %if %superq(fn)= %then
    %do;&arr.[&i.1]%do n=2 %to &n.;&sep. &arr.[&i.&n.]%end;%end;
    %else
    %do;&fn.(&arr.[&i.1])%do n=2 %to &n.;&sep. &fn.(&arr.[&i.&n.])%end;%end;
    %mend chain;
    ;;;;
    run;quit;

    filename ft15f001 "c:/oto/generateCheck.sas";
    parmcards4;
    %macro generateCheck(
      n /* number of varibles used for suming */
    , val /* total we are looking for */
    , arr=x /* array name */
    , i=i   /* iterator prefix */
    );

    data check;
    set t;

    array &arr.[*] _numeric_;

    i0=0;
    keep list1 list2;

    %do n=1 %to &n.;
    do i&n.=i%eval(&n.-1)+1 to dim(x);
    if (%chain(&n.,arr=&arr.,i=&i.,sep=+) > &val.) then continue;
    else if (%chain(&n.,arr=&arr.,i=&i.,sep=+) = &val.) then do;
    list1 = catx(" ", %chain(&n.,arr=&arr.,i=&i.,sep=%str(,),fn=vname) );
    list2 = catx(" ", %chain(&n.,arr=&arr.,i=&i.,sep=%str(,)) );
    output; end;
    else
    %end;
    ;
    %do n=1 %to %eval(&n.-1);
    end;
    %end;
    run;
    proc print data=check;
    run;

    %mend generateCheck;
    ;;;;
    run;quit;

    /*___                                            _                                     _
    | ___|   ___ ___  _ __ ___  _ __ ___   ___ _ __ | |_ ___    ___  _ __    ___ _ __   __| |
    |___ \  / __/ _ \| `_ ` _ \| `_ ` _ \ / _ \ `_ \| __/ __|  / _ \| `_ \  / _ \ `_ \ / _` |
     ___) || (_| (_) | | | | | | | | | | |  __/ | | | |_\__ \ | (_) | | | ||  __/ | | | (_| |
    |____/  \___\___/|_| |_| |_|_| |_| |_|\___|_| |_|\__|___/  \___/|_| |_| \___|_| |_|\__,_|

    */

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

     /*              _
       ___ _ __   __| |
      / _ \ `_ \ / _` |
     |  __/ | | | (_| |
      \___|_| |_|\__,_|

     */
