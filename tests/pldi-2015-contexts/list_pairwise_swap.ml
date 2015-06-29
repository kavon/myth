#use "context.decls"

let list_pairwise_swap : list -> list |>
{ [] => []
| [0] => []
| [0;1] => [1;0]
| [1;0;1] => []
| [0;1;0;1] => [1;0;1;0]
| [1] => []
| [1;0] => [0;1]
} = ?
