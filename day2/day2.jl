### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ 79d8de3d-0120-4245-a066-4b6f5f8f8626
using Test

# ╔═╡ a68d1424-b8dc-4ebe-b674-ad22aaad6095
md"# Day 2: Rock Paper Scissors"

# ╔═╡ 71b46256-1a7c-431f-8546-fa9cb78ed5ab
md"## Part 1"

# ╔═╡ ca304fe8-d7b5-4bff-a3ec-4c533b8e8636
total_score(line::String) = total_score(line[1], line[3])

# ╔═╡ f4c99400-f512-4ac6-8a59-bfdce5070722
function shape_score(shape::Char)
	if shape ∈ ('A', 'X') return 1 end
	if shape ∈ ('B', 'Y') return 2 end
	if shape ∈ ('C', 'Z') return 3 end
end

# ╔═╡ bebad702-d776-4ad6-bb34-ec6b1ad81fa3
md"Test against examples in blurb"

# ╔═╡ fc531bdb-dcc2-47d3-9e5d-ac594568e4ec
md"## Part 2"

# ╔═╡ 3212e7fc-5513-465b-857a-9169d6a9ed9f
md"""
I could go back and improve the way I did part 1 but I suspect it's quicker to just hack a conversion.
I kinda wish I had done the Int hacky way now...
"""

# ╔═╡ 9d1e325f-5b0f-4ec5-a42e-714e48e365fe
total_score_part2(line::String) = total_score_part2(line[1], line[3])

# ╔═╡ 165a8091-82e2-4016-b0d4-ea42b787cc06
md"# Alternative approaches"

# ╔═╡ 11ff3305-4158-424c-af90-c38c1e3c6c9c
md"""
## Char as Int
"""

# ╔═╡ 21e788af-2a49-4e4c-ad9f-a999279ef457
total_score_cai(line::String) = total_score_cai(line[1], line[3])

# ╔═╡ ee596a27-6b5e-4e73-88b3-97aa9251b63f
function shape_score_cai(shape::Char)
	(Int(shape) - Int('X') + 1)
end

# ╔═╡ fda7fded-7307-4b21-9ec3-6a61f248c995
XtoA = Int('X') - Int('A')

# ╔═╡ ec09b38e-a5e7-4625-8278-d5bd79bc78c7
function win_score_cai(their_shape::Char, my_shape::Char)
	(mod(Int(my_shape) - Int(their_shape) - XtoA + 1,3))*3
end

# ╔═╡ 3a7af762-9f89-4d7c-a9fd-cfae2f06cbec
total_score_cai(their_shape::Char, my_shape::Char) = win_score_cai(their_shape, my_shape) + shape_score_cai(my_shape)

# ╔═╡ 8f939856-70c2-439e-9ab6-0bc8b06cad5d
readlines("input") .|> total_score_cai |> sum

# ╔═╡ dd386486-a59d-4a59-86cf-3ee7ce039c5d
md"## Use enums?"

# ╔═╡ 7af7f1d7-40d3-4565-9808-b027cf13d386
md"# Appendix"

# ╔═╡ 148d4d78-87f7-4b9f-aa92-f1d37ec9fdce
begin
	A = 'A'
	B = 'B'
	C = 'C'
	X = 'X'
	Y = 'Y'
	Z = 'Z'
end

# ╔═╡ b94a0083-ad66-4c46-9780-dbe4b63148ef
function win_score(their_shape::Char, my_shape::Char)
	state = (their_shape, my_shape)
	if state ∈ [(A,Z), (B,X), (C,Y)] return 0 end
	if state ∈ [(A,X), (B,Y), (C,Z)] return 3 end
	if state ∈ [(A,Y), (B,Z), (C,X)] return 6 end
	error("Their shape (first arg) must be one of (A,B,C) my shape (second arg) must be one of (X,Y,Z)")
end

# ╔═╡ 61ff7176-cefe-40fa-a846-a0ca2880a9bd
total_score(their_shape::Char, my_shape::Char) = win_score(their_shape, my_shape) + shape_score(my_shape)

# ╔═╡ fa76d0c0-7354-11ed-27cc-1bea3f965cd0
readlines("input") .|> total_score |> sum

# ╔═╡ c59ba6e7-25ad-4fc9-beda-176ea52947c3
total_score("A Y")

# ╔═╡ 9c3a4a24-f044-4fd0-a410-a5d31ec72960
@test total_score("A Y") == 8

# ╔═╡ b2730630-ba4c-4442-91cd-2897dbdabfa7
@test total_score("B X") == 1

# ╔═╡ 1d93314c-1ae8-4227-9f6d-957a12480e6c
@test total_score("C Z") == 6

# ╔═╡ 1819decc-d120-4826-8d17-3bbc2f4a0bf8
function outcome_to_shape(their_shape::Char, my_outcome::Char)
	if my_outcome == X # lose
		if their_shape == A return Z end
		if their_shape == B return X end
		if their_shape == C return Y end
	elseif my_outcome == Y # draw
		if their_shape == A return X end
		if their_shape == B return Y end
		if their_shape == C return Z end
	elseif my_outcome == Z # win
		if their_shape == A return Y end
		if their_shape == B return Z end
		if their_shape == C return X end
	else
		error("Their shape (first arg) must be one of (A,B,C) my outcome (second arg) must be one of (X,Y,Z)")
	end
end

# ╔═╡ a9644f29-5894-404c-ac02-f23f39409614
function total_score_part2(their_shape::Char, my_outcome::Char)
	return total_score(their_shape, outcome_to_shape(their_shape, my_outcome))
end

# ╔═╡ 131d0d6f-d5b1-49d7-b428-d41e49793dd8
readlines("input") .|> total_score_part2 |> sum

# ╔═╡ 42d5ebf9-5259-4e37-be2d-716085443118
@test total_score_part2(A,Y) == 4

# ╔═╡ 65a7d231-b362-4a79-9fe4-4c055f6b0b60
@test total_score_part2(B,X) == 1

# ╔═╡ ba6bfa55-1e9f-4309-bcb0-4e1c91eeeef9
@test total_score_part2(C,Z) == 7

# ╔═╡ 3ca4fe09-e62b-4059-9ae2-34113613ce1b
@test win_score_cai(A,X) == win_score_cai(B,Y) == win_score_cai(C,Z) == 3

# ╔═╡ e5abca5d-308a-4f2e-a1f9-c3a1b4dfd759
@test win_score_cai(A,Y) == win_score_cai(B,Z) == win_score_cai(C,X) == 6

# ╔═╡ f7e3f858-529c-4656-a6d4-d8413cd9a025
@test win_score_cai(A,Z) == win_score_cai(B,X) == win_score_cai(C,Y) == 0

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "71d91126b5a1fb1020e1098d9d492de2a4438fd2"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ Cell order:
# ╟─a68d1424-b8dc-4ebe-b674-ad22aaad6095
# ╟─71b46256-1a7c-431f-8546-fa9cb78ed5ab
# ╠═fa76d0c0-7354-11ed-27cc-1bea3f965cd0
# ╠═c59ba6e7-25ad-4fc9-beda-176ea52947c3
# ╠═ca304fe8-d7b5-4bff-a3ec-4c533b8e8636
# ╠═61ff7176-cefe-40fa-a846-a0ca2880a9bd
# ╠═f4c99400-f512-4ac6-8a59-bfdce5070722
# ╠═b94a0083-ad66-4c46-9780-dbe4b63148ef
# ╟─bebad702-d776-4ad6-bb34-ec6b1ad81fa3
# ╠═9c3a4a24-f044-4fd0-a410-a5d31ec72960
# ╠═b2730630-ba4c-4442-91cd-2897dbdabfa7
# ╠═1d93314c-1ae8-4227-9f6d-957a12480e6c
# ╟─fc531bdb-dcc2-47d3-9e5d-ac594568e4ec
# ╠═131d0d6f-d5b1-49d7-b428-d41e49793dd8
# ╟─3212e7fc-5513-465b-857a-9169d6a9ed9f
# ╠═9d1e325f-5b0f-4ec5-a42e-714e48e365fe
# ╠═a9644f29-5894-404c-ac02-f23f39409614
# ╠═1819decc-d120-4826-8d17-3bbc2f4a0bf8
# ╠═42d5ebf9-5259-4e37-be2d-716085443118
# ╠═65a7d231-b362-4a79-9fe4-4c055f6b0b60
# ╠═ba6bfa55-1e9f-4309-bcb0-4e1c91eeeef9
# ╟─165a8091-82e2-4016-b0d4-ea42b787cc06
# ╟─11ff3305-4158-424c-af90-c38c1e3c6c9c
# ╠═8f939856-70c2-439e-9ab6-0bc8b06cad5d
# ╠═21e788af-2a49-4e4c-ad9f-a999279ef457
# ╠═3a7af762-9f89-4d7c-a9fd-cfae2f06cbec
# ╠═ee596a27-6b5e-4e73-88b3-97aa9251b63f
# ╠═3ca4fe09-e62b-4059-9ae2-34113613ce1b
# ╠═e5abca5d-308a-4f2e-a1f9-c3a1b4dfd759
# ╠═f7e3f858-529c-4656-a6d4-d8413cd9a025
# ╠═ec09b38e-a5e7-4625-8278-d5bd79bc78c7
# ╠═fda7fded-7307-4b21-9ec3-6a61f248c995
# ╟─dd386486-a59d-4a59-86cf-3ee7ce039c5d
# ╟─7af7f1d7-40d3-4565-9808-b027cf13d386
# ╠═79d8de3d-0120-4245-a066-4b6f5f8f8626
# ╠═148d4d78-87f7-4b9f-aa92-f1d37ec9fdce
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
