## basic types, Binaries, string, and char lists

elixir 中基本的数据类型
 
https://elixir-lang.org/getting-started/basic-types.html
https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html

## guard 规则

```
Guards
Guards are a way to augment pattern matching with more complex checks. They are allowed in a predefined set of constructs where pattern matching is allowed.

Not all expressions are allowed in guard clauses, but only a handful of them. This is a deliberate choice. This way, Elixir (and Erlang) can make sure that nothing bad happens while executing guards and no mutations happen anywhere. It also allows the compiler to optimize the code related to guards efficiently.
```

可以在guard 里用严格的 boolean 操作符，and, or, not; 不要求两边都是 boolean 值的操作符号（&&, ||, !）不能用在 guard 里面.