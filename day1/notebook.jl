### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ 0dc4d504-83f4-408c-8755-d93ec1d529ca
md"## Part 1"

# ╔═╡ 96413a85-792b-4534-96f2-ed81f567c4a5
md"## Part 2"

# ╔═╡ 3352214c-daa0-4bd1-9ee9-f569988666d5
md"## Other approaches"

# ╔═╡ d549ea9d-129c-4307-9aa2-db64a6619541
md"A hacky and functional flavoured approach, it's inefficient and bit messy. "

# ╔═╡ 810891c0-630e-42e0-85e3-8b3f6f02f9dd
md"It's also frustrating that we have to define our own curried functions, they should really be built in."

# ╔═╡ a5bad1a8-3605-4e6d-ab32-32041ee4c03d
Base.join(c::Char) = v->join(v,c)

# ╔═╡ 65b7a54b-4de6-46bd-a5de-f0cbca1ccc9a
Base.parse(dt::DataType) = x->parse(dt,x)

# ╔═╡ 2b7bce54-7ada-4d11-a04f-c31158958c7e
begin
	totals = []
	total = 0
	for line in readlines("input")
		if line == ""
			push!(totals, total)
			total = 0
		else
			total += parse(Int, line)
		end
	end
end

# ╔═╡ e8f996aa-73be-4c10-aba7-bf6d02d64ec2
maximum(totals)

# ╔═╡ a89a8922-2dd8-41ee-94fc-725315fd7e4c
sort(totals; rev=true)[1:3] |> sum

# ╔═╡ c808cc4c-01e2-4300-b95e-a5602ef79979
Base.map(f::Function) = v->map(f, v)

# ╔═╡ 5efc57c8-1ce6-45e8-a4b6-fe927782eedc
(readlines("input") |>
	join(',') |>
	x->split(x,",,") .|>
	x->split(x,",") .|>
	parse(Int)) |>
	map(sum) 

# ╔═╡ 06582d09-997e-4010-b260-d41f3a4ce127
md"A nice way to parse the file while handling blanks, but not really needed"

# ╔═╡ a0a52d1f-800e-4672-a36a-1917beb9b205
tryparse.(Int, readlines("input"))

# ╔═╡ Cell order:
# ╟─0dc4d504-83f4-408c-8755-d93ec1d529ca
# ╠═2b7bce54-7ada-4d11-a04f-c31158958c7e
# ╠═e8f996aa-73be-4c10-aba7-bf6d02d64ec2
# ╟─96413a85-792b-4534-96f2-ed81f567c4a5
# ╠═a89a8922-2dd8-41ee-94fc-725315fd7e4c
# ╟─3352214c-daa0-4bd1-9ee9-f569988666d5
# ╟─d549ea9d-129c-4307-9aa2-db64a6619541
# ╠═5efc57c8-1ce6-45e8-a4b6-fe927782eedc
# ╟─810891c0-630e-42e0-85e3-8b3f6f02f9dd
# ╠═a5bad1a8-3605-4e6d-ab32-32041ee4c03d
# ╠═65b7a54b-4de6-46bd-a5de-f0cbca1ccc9a
# ╠═c808cc4c-01e2-4300-b95e-a5602ef79979
# ╟─06582d09-997e-4010-b260-d41f3a4ce127
# ╠═a0a52d1f-800e-4672-a36a-1917beb9b205
