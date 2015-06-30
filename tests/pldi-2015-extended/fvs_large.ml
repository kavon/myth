type nat =
  | O
  | S of nat

type list =
  | Nil
  | Cons of nat * list

type exp =
  | Unit
  | BVar of nat
  | FVar of nat
  | Lam of nat * exp
  | App of exp * exp
  | Pair of exp * exp
  | Fst of exp
  | Snd of exp
  | Inl of exp
  | Inr of exp
  | Const of nat
  | Add of exp * exp
  | Sub of exp * exp
  | Mult of exp * exp
  | Div of exp * exp

let rec append (l1:list) (l2:list) : list =
  match l1 with
  | Nil -> l2
  | Cons (x, l1p) -> Cons (x, append l1p l2)
;;

let fvs_large : exp -> list |>
  { Unit => []
  | FVar (0) => [0]
  | FVar (1) => [1]
  | FVar (2) => [2]
  | BVar (0) => []
  | Lam (0, Unit) => []
  | Lam (0, FVar (1)) => [1]
  | App (Unit, Unit) => []
  | App (FVar (0), Unit) => [0]
  | App (Unit, FVar (1)) => [1]
  | Fst (Unit) => []
  | Fst (FVar (1)) => [1]
  | Snd (Unit) => []
  | Snd (FVar (1)) => [1]
  | Pair (Unit, Unit) => []
  | Pair (FVar (0), Unit) => [0]
  | Pair (Unit, FVar (1)) => [1]
  | Pair (FVar (0), FVar (1)) => [0; 1]
  | Inl (Unit) => []
  | Inl (FVar (1)) => [1]
  | Inr (Unit) => []
  | Inr (FVar (1)) => [1]
  | Const (0) => []
  | Add (FVar (0), Unit) => [0]
  | Add (Unit, FVar (1)) => [1]
  | Sub (FVar (0), Unit) => [0]
  | Sub (Unit, FVar (1)) => [1]
  | Mult (FVar (0), Unit) => [0]
  | Mult (Unit, FVar (1)) => [1]
  | Div (FVar (0), Unit) => [0]
  | Div (Unit, FVar (1)) => [1]
  } = ?
