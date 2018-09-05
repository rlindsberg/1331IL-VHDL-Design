#### Full Adder

|sum|carry|
|-|-|
|5 ns|5 ns|

#### 4-bit Ripple Adder

carry0 -> carry1 -> carry2 -> carry out: 3 * 5 ns = 15 ns

|sum|carry|
|-|-|
|5 ns|15 ns|

#### 4-bit Carry Lookahead Adder

|sum|carry|
|-|-|
|5 ns|5 ns|

#### 8-bit Carry Select Adder

4-bit ripple adder sum + mux = 5 + 5 = 10 ns

4-bit ripple adder carry + OR + AND = 15 + 3 + 3 = 21 ns

|sum|carry|
|-|-|
|10 ns|21 ns|

### Resultat
*enhet: ns*

| Krets                        |Sum |Carry|
|-|-|
| Full Adder                   | 5  |  5  |
| 4-bit Ripple Adder           | 5  |  15 |
| 4-bit Carry Lookahead Adder  | 5  |  5  |
| 8-bit Carry Select Adder     | 10 |  21 |
