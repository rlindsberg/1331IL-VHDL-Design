#### Full Adder

|sum|carry|
|-|-|
|5 ns|5 ns|

#### 4-bit Ripple Adder

Full Adder -> Full Adder -> Full Adder -> Full Adder -> sum
5 + 5 + 5 + 5 = 20

|sum|carry|
|-|-|
|20 ns|20 ns|

#### 4-bit Carry Lookahead Adder

|sum|carry|
|-|-|
|5 ns|5 ns|

#### 8-bit Carry Select Adder

4-bit ripple adder sum + mux = 20 + 4 = 24 ns

4-bit ripple adder carry + OR + AND = 20 + 3 + 3 = 26 ns

|sum|carry|
|-|-|
|10 ns|21 ns|

### Resultat
*enhet: ns*

| Krets                        |Sum  |Carry|
|-|-|
| Full Adder                   | 5   |  5  |
| 4-bit Ripple Adder           | 20  |  20 |
| 4-bit Carry Lookahead Adder  | 5   |  5  |
| 8-bit Carry Select Adder     | 24  |  26 |
