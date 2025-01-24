### A Pluto.jl notebook ###
# v0.20.3

#> [frontmatter]
#> license_url = "https://opensource.org/license/unlicense"
#> title = "Handcalcs"
#> date = "2025-01-23"
#> tags = ["math"]
#> description = "Calculations you can read and reuse"
#> license = "Unlicense"
#> 
#>     [[frontmatter.author]]
#>     name = "Cole Miller"
#>     url = "https://github.com/co1emi11er2/Handcalcs.jl"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 12d41162-b9aa-11ef-33d9-a32698d6f054
begin
	using Revise, Handcalcs, StructuralUnits, Format, PlutoUI, LaTeXStrings, Plots, Markdown, TestHandcalcFunctions
end

# ╔═╡ 5ac917a4-79bf-419e-9eff-6501c2d15d28
PlutoUI.TableOfContents()

# ╔═╡ bd811c3e-6802-4c5a-9904-9e6044c976be
md"# Handcalcs.jl"

# ╔═╡ a8bb7d69-55a4-4381-aa98-b2169d3064d7
md"[Handcalcs.jl](https://co1emi11er2.github.io/Handcalcs.jl/dev/) is a package that was design to be used in Pluto! This package supplies macros to generate $LaTeX$ formatted strings from mathmatical formulas. Handcalcs.jl takes inspiration from [handcalcs.py](https://github.com/connorferster/handcalcs) which is a python package that works best in jupyter notebooks. "

# ╔═╡ 897f866e-40ef-4c47-993e-40f58f8c340b
md"# Brief Tutorial of Handcalcs"

# ╔═╡ 98ec50cc-dddf-48ac-9806-990a9e2e334a
md"""
Handcalcs exports two macros where all of the functionality stems from:
- `@handcalc`
- `@handcalcs`

Think of `@handcalc` as doing a single inline \$ *latex expression* \$, and `@handcalcs` as a multiline display equation \$\$ *latex expression* \$\$.

I primarily use `@handcalcs`. It can even be inlined into markdown as well. It also handles multiple expressions, and generally does a better job at cleaning up the equations for redundant information.
"""

# ╔═╡ 18eded2b-f973-4a61-9754-56331fd01336
md"""
Change this setting in the notebook to change the alignment of the expressions to the left.

Left Align Equations: $(@bind left_aligned PlutoUI.CheckBox())
"""

# ╔═╡ ba51899c-61d6-440d-8263-d479f6a871f6
if left_aligned
html"""
<style>
	mjx-container {
		text-align: left !important;
	}
</style>
"""
end

# ╔═╡ a2758980-252e-4e6b-baf3-a5a6e85df34d
md"## Single Expression Example"

# ╔═╡ 27b55f64-358e-4bc2-a5f4-315ea361b646
md"Lets try to calculate the area of a circle"

# ╔═╡ 0eac9a5a-c6a8-43e9-99c9-16f7c3d77204
d = 5;

# ╔═╡ 00e75249-8d2c-4407-9564-68c8d79fc29f
@handcalcs begin
	area = π*d^2/4
end

# ╔═╡ 2a7e9993-74f9-48f8-964b-e858e3b96672
md"Handcalcs was able to show the equation defining `area` as a $LaTeX$ expression showing both the symbolic and numeric parts. The variable `area` was also evaluated!"

# ╔═╡ 3589a61a-84a2-4413-9fb9-3454105f6df2
area

# ╔═╡ f3a4d941-fcd4-421b-94e4-2d486e71da12
md"The number of decimals in the above expression may be too much. Let change that."

# ╔═╡ 69f31cc2-af12-4a8c-bbf1-9959f9d78b4f
md"""
!!! note
	The number of decimals you see in the area calc may just be 2. The way pluto works, the cell below may have changed the output. Just know that without the cell below, the number of decimals would be too much.
"""

# ╔═╡ 79f4fb1c-e512-4af6-835c-ea0865d80c5e
begin
	set_default(fmt = x->format(round(x, digits=2)))
end

# ╔═╡ cd4ab653-0627-44e4-8b58-c475e0a0a251
md"Handcalcs uses [Latexify.jl](https://github.com/korsbo/Latexify.jl) under the hood, so you can use the `set_default` function from Latexify to change the default settings of the output, or you can add it to the end of the handcalcs expression similar to the `@latexdefine` macro in Latexify.

See [here](https://korsbo.github.io/Latexify.jl/stable/#Setting-your-own-defaults) for more details in the Latexify docs."

# ╔═╡ 99730005-9dca-48aa-a409-5b0438660220
let # adding let here to avoid pluto variable clash
@handcalcs begin
	area = π*d^2/4
end
end

# ╔═╡ 6633dd4a-2b68-4127-90ed-9e4caab68f56
md"## Multiple Expression Example"

# ╔═╡ c0a250de-36dd-4647-9281-c237e9efd359
md"Now lets see how Handcalcs handles multiple expressions!"

# ╔═╡ b5c7a277-da51-487b-869e-1936816017ac
a = 2;

# ╔═╡ 54ea2e03-ab01-4371-a13d-c3de13876c10
b = -5;

# ╔═╡ ef8baa5a-90ef-4a67-94bc-40d6c50abe74
c = 2;

# ╔═╡ ec3681b3-7c95-4c4e-8320-89f535440d92
md"This time lets show the variables we defined above in $LaTeX$ as well"

# ╔═╡ 1c5ec9af-8f8b-416d-ad76-aec0af292895
@handcalcs begin
	a
	b
	c
end color=:blue cols=3

# ╔═╡ 20503429-f22b-49b0-9f06-3ffcfc811a93
md"Here we changed the color of the output as well as the number of columns by adding a few extra parameters to the macro"

# ╔═╡ fd00ab45-3967-4159-88a3-e6a924be40bc
@handcalcs begin
	x_1 = (-b + sqrt(b^2 - 4*a*c))/ (2*a)
	x_2 = (-b - sqrt(b^2 - 4*a*c))/ (2*a)
end

# ╔═╡ 350d438e-1cfa-4c4c-85ff-afdfecfc171e
md"You can see `@handcalcs` handles multiple expressions with ease, and yes `x_1` and `x_2` are evaluated as expected"

# ╔═╡ 43633b23-b5cd-45ad-893f-ecd766726610
x_1, x_2

# ╔═╡ 778b64c5-6a06-4e74-8da6-67a83f08eac5
md"When an equation is too long, you can also add the setting below. 

You can also add a comment using the syntax shown below."

# ╔═╡ 4b8d463f-b186-4d1f-9b80-62ff7a5a886d
let # adding let here to avoid pluto variable clash
@handcalcs begin
	x_1 = (-b + sqrt(b^2 - 4*a*c))/ (2*a); "this is a comment";
end len = :long
end

# ╔═╡ 24c12e97-4090-48a4-8c66-bb5d2068e1e4
md"## Changing Default Settings of Handcalcs"

# ╔═╡ 3867ea24-0e62-46bf-84e3-b86bc3e74ae7
md"Similarly with Latexify, Handcalcs has a way to change some default settings using the `set_handcalcs` function. Some of the settings you have seen so far are:
- `color`: change the color of the output (`:blue`, `:red`, etc)
- `cols`: change the number of columns the expression returns (default = 1).
- `len`: can set to `:long` and it will split equation to multiple lines
but there are more! See [here](https://co1emi11er2.github.io/Handcalcs.jl/stable/tutorial/#Changing-Default-Settings:) for more details."

# ╔═╡ ad2ea96b-4b87-49ed-bd5e-37aca4f8973d
md"## Using Unitful with UnitfulLatexify"

# ╔═╡ bec7dfa6-8787-45b7-b2cb-230666712a3f
md"This package integrates with [Unitful.jl](https://painterqubits.github.io/Unitful.jl/stable/) and [UnitfulLatexify](https://gustaphe.github.io/UnitfulLatexify.jl/stable/)"

# ╔═╡ 5dd3bce5-9f12-480d-9000-ec84766c18be
let
a = 2u"inch"
b = -5u"inch"
@handcalcs c = sqrt(a^2 + b^2)
end

# ╔═╡ 07ff6778-df02-4dc1-81ba-661afaec6320
md"If you want to set the units of the output, you can write it the same way you would using Unitful. The @handcalcs macro will parse the |> operator out of the output while still evaluating the result with the conversion."

# ╔═╡ b2237f22-b523-4f71-b196-85e1fdddb393
let
	b = 40u"ft"
	t = 8.5u"inch"
	@handcalcs begin
    	b
    	t
    	a = b * t       |> u"inch"^2
    	Ix = b*t^3/12   |> u"inch"^4
	end
end

# ╔═╡ 740bda9e-8191-447b-ba1d-e5a8784fca84
md"## The BEST Part - Function Examples"

# ╔═╡ 42e089cd-1ec2-4924-ac4a-d42d18c9c68a
md"""
The @handcalcs macro will automatically try to "unroll" the expressions within a function when the expression has the following pattern: `variable = function_name(args...; kwargs...)`. Note that this is recursive, so if you have a function that calls other functions where the expressions that call the function are of the format mentioned, it will continue to step into each function to "unroll" all expressions.

One issue that can arise are for the functions that you do not want to unroll. Consider the expression: `y = sin(x)` or `y = x + 5`. Both of these expressions match the format: `variable = function_name(args...; kwargs...)` and would be unrolled. This would result in an error since these functions don't have generic math expressions that can be latexified. You will need to use the `not_funcs` keyword to manually tell the @handcalcs macro to pass over these functions. Some of the common math functions that you will not want to unroll are automatically passed over. See examples below.
"""

# ╔═╡ 3f2d9d3e-82f9-4cc7-bf06-18bd33dde4c0
md"### Function Unrolling Example: `calc_Ix`"

# ╔═╡ 081762c8-3109-438a-abd4-17f20c7db455
md"There is a function that is defined in the TestHandcalcsFunctions.jl package called `calc_Ix`. The definition looks like the following:
```
function calc_Ix(b, h)
    Ix = b*h^3/12
    return Ix
end
```

Lets try to call that function within our `@handcalcs` macro."

# ╔═╡ 4b9ff29b-d777-4694-926a-5c95851e81e7
let
b = 5 # width
h = 15 # height
@handcalcs Ix = calc_Ix(b, h)
end

# ╔═╡ 7c09b665-e48b-4825-bd75-4540ba12afeb
md"The Ix variable is evaluated. Ix being the variable assigned in the @handcalcs part (variables within function are not defined in the global name space). If you assign it to a different variable then that will be the variable defined (although you will still see it as Ix in the latex portion). Also note that return statements are filtered out of the function body, so keep relevant parts separate from return statements."

# ╔═╡ 9d6f3c2a-fe77-4712-94b5-1dd9c61edc22
md"### Recursive Function Unrolling Example: `calc_Is`"

# ╔═╡ e266ab7d-21a6-4f91-a229-102e27a4e68d
md"This macro is recursive! If the function that you call contains another function call that matches the form `variable = function_name(args...; kwargs...)`, then @handcalcs will try to unroll that one as well! Lets see an example with the `calc_Is` function defined in the TestHandcalcsFunction.jl package. The function definition is shown below:
```
function calc_Is(b, h) # function defined in TestHandcalcFunctions
    Ix = calc_Ix(b, h)
    Iy = calc_Iy(h, b)
    return Ix, Iy
end;
```"

# ╔═╡ bdb88b43-7c4f-48a8-b6b5-0130cf5f402a
let
	x = 0
	@handcalcs begin
		y = sin(x)
		z = cos(x)
		I_x, I_y = TestHandcalcFunctions.calc_Is(5, 15)
	end not_funcs = [:sin :cos]
end

# ╔═╡ 8a0028f1-1d1d-4448-a20a-9bc25b17e02c
md"""
In the above example `sin` and `cos` were passed over and `calc_Is` was not. As you can see, the `calc_Is` function was a function that called other functions, and the `@handcalcs` macro continued to step into each function to unroll all expressions. Please see below for a list of the current functions that are passed over automatically. Please submit a pull request if you would like to add more generic math functions that I have left out.

```
const math_syms = [
    :*, :/, :^, :+, :-, :%,
    :.*, :./, :.^, :.+, :.-, :.%,
    :<, :>, Symbol(==), :<=, :>=,
    :.<, :.>, :.==, :.<=, :.>=,
    :sqrt, :sin, :cos, :tan, :sum, 
    :cumsum, :max, :min, :exp, :log,
    :log10, :√]
```

If you want to add functions to your specific project, you can do the following:
```
set_handcalcs(not_funcs = [:foo :bar :baz])
```

!!! warning "Current Limitations for `@handcalcs`"
	- The function needs to be defined in another package. The `@code_expr` macro from `CodeTracking.jl` does not see functions in Main for some reason (unless in the REPL).
"""

# ╔═╡ c2252cdb-4151-4a2a-b421-2e808bb26883
md"### Writing Packages"

# ╔═╡ 5ba38942-a676-40a7-9d9c-821f76d642d6
md"""
So you might be thinking, 

\"Does that mean I can write packages filled with julia functions and this just works?\" 
- Yes, that is exactly what you can do and what the package is being developed for. 

\"What julia language features work (if statements, for loops, vectors, etc)\"
- General mathmatical expressions work
- If statements work in some ways but are limited (this is the next area of improvement). Latexify is limited, so it is a matter of figuring out where to add the improvments.
- For loops is not something Latexify can do. Although, the idea of this tool is to show the work of what is being done. Since for loops repeat the work being done, I recommend showing the work inside the loop and then running the loop separate.
- Vectors do work. However, they need to be relatively small or the expression just gets too big. This is another one where I would recommend showing the expressions for one element in the vector or vectors and do the operation with the vectors separate. 

\"This looks pretty cool, but is this slow?\"
- Compared to the pure julia expressions, yes.
- The non-function unrolling expressions are controlled by the speed of Latexify, so if Latexify gets faster, this will. I haven't found the need for it yet though.
- The function-unrolling parts are even slower. It is currently using `@eval`, but I am not sure how to get rid of it. I want to improve this as well if possible, but I currently don't have the need for it yet either.
"""

# ╔═╡ a7064738-e518-42c6-9aa8-f8bc2e013f2d
md"# Actual Project Demo: AISCSteel"

# ╔═╡ fdee2c0c-add7-4e08-a307-9259711a61b1
md"Here is a short demo of the idea of the use case of the Handcalcs.jl package. The idea that you can write a Julia package and use Handcalcs to create documentation/report of the package"

# ╔═╡ eed9bbf2-8993-4df6-a7fd-243e5169c8dd
md"The AISCSteel.jl package isn't important here, but I will use it to demonstrate a use case for Handcalcs. The package is based on [AISC360](https://www.aisc.org/globalassets/aisc/publications/standards/a360-16w-rev-june-2019.pdf) and the demo will go through Chapter F, and will design an I-Shaped beam for flexure. You can follow along in Chapter F or just read along. I will hide the handcalc cells so be sure to run the notebook if you want to see the code (I am calling functions within the AISCSteel package)."

# ╔═╡ cae8c270-c620-4bb4-9175-a8702e7ed7ab
begin
	import AISCSteel
	import AISCSteel.Shapes.IShapes.RolledIShapes: WShape
	import AISCSteel.Shapes.IShapes.RolledIShapes.Flexure as Flexure
	import AISCSteel.ChapterFFlexure as Chf
end

# ╔═╡ 419375f5-1f14-465e-8d3f-3c7fd5664166
md"""
## Example Problem
Determine the LRFD flexural design strength for a W10x12 beam with an unbraced length of 10 ft.

Other beams to try:
- W30x235
- W12x26
"""

# ╔═╡ 4b33c7b8-460e-4248-bbb6-58ebe434fa0c
begin
w_list = ["W10X12", "W30X235", "W12X26"]
w_fy_list = [50ksi, 200ksi, 500ksi]
end;

# ╔═╡ 73050a9f-3938-4d90-b7d6-e145ae7c6a9d
md"""
Select W-Shape: $(@bind w_name PlutoUI.Select(w_list))

Select Steel Strength: $(@bind w_fy PlutoUI.Select(w_fy_list)) (change to unrealistic **200ksi** or **500ksi** for `F4` or `F5` equations on first beam)
"""

# ╔═╡ 1a2b22b3-b730-4475-85cb-ec284ae1612c
w = WShape(w_name, F_y=w_fy)

# ╔═╡ f827503c-ef71-48e1-9e54-c46afd810bed
md"Lateral braced length: $(@bind L_b PlutoUI.Select([2ft, 5ft, 10ft]))"

# ╔═╡ 1cc8d792-6850-490c-bc1a-12c1059acf1b
L_b

# ╔═╡ 089d48f6-76fa-4610-a007-c18246ef25cb
ϕ_b = 0.9;

# ╔═╡ 209b7fc9-a06a-43de-9400-fa6537d4350c
max_x = 20ft*1;

# ╔═╡ 1ee5a282-0919-4e2a-982a-845a89de384d
begin
(;h,
t_f,
b_f,
t_w,
E,
F_y,
S_x,
) = w
end;

# ╔═╡ 083d1e86-90da-4e54-adbb-06939a665c3f
md"### Section Properties of $(w.shape)"

# ╔═╡ bf97f95b-860b-4367-b5bd-6081c384dd40
@handcalcs begin
	h
	t_f
	b_f
	t_w
	E 
	F_y
	S_x
end color = :blue cols=4

# ╔═╡ 5cec6944-201d-498e-b2e1-6844c8c56d2b
let
	xs = collect(0ft:0.1ft:max_x) 
	M_ns = [Flexure.calc_Mn(w, x)*ϕ_b for x in xs] .|> kip*ft

	M_n = Flexure.calc_Mn(w, L_b)*ϕ_b
	M_n = round(kip*ft, M_n, digits=2)
	
	plot(xs, M_ns, label="Moment Capacity")
    scatter!([L_b], [Flexure.calc_Mn(w, L_b)*ϕ_b], 
		xlabel="Lateral Braced Length", 
		ylabel="Moment", 
		label="ϕM_n",
		title="$(w.shape) Moment Capacity ($(Flexure.classify_section(w)))",
		series_annotations = [Plots.text("   $M_n", 6, :left)]
	)
end

# ╔═╡ 2d322e46-9b1b-44d2-9a93-9dea65945768
md" ## Determine if Section is Compact"

# ╔═╡ 08701b61-f7a5-4e0e-9844-254c331f2276
md"""
## Determine the limiting ratios (AISC Table B4.1b)
### Check Flange
"""

# ╔═╡ 536885c8-73d7-47ab-9b79-6071391d5710
@handcalcs begin
λ_f, λ_pf, λ_rf, λ_fclass = Flexure.classify_flange(w)
end

# ╔═╡ 01cd1817-7493-4c4e-908d-0fba32860bb4
L"\text{\color{blue}Flange is %$λ_fclass}"

# ╔═╡ 29bbc01a-c3e4-44b1-94ee-a7ec102308c0
md"### Check Web"

# ╔═╡ 5eb052e9-5f8c-4502-8ac3-7ab87bab1361
@handcalcs begin
λ_w, λ_pw, λ_rw, λ_wclass = Flexure.classify_web(w)
end

# ╔═╡ f12e06f8-1dfc-4e04-bd9a-1da1d733fe56
L"\text{\color{blue}Web is %$λ_wclass}"

# ╔═╡ ad759d44-ab32-4ca8-b7e7-664720df987d
begin
	section_class = Flexure.classify_section(w)
	L"\text{\color{blue} W-Shape is classified as %$section_class}"
end

# ╔═╡ 9c734a4d-afc0-42ba-91e7-4044b40d8032
if λ_fclass == :compact
	md"## Determine Flexural Capacity based on Chapter F, Section 2"
else
	md"## Determine Flexural Capacity based on Chapter F, Section 3"
end

# ╔═╡ 208b1627-8bc3-48ae-b150-6d4ad63a475b
md"### Calculate Miscellaneous Variables"

# ╔═╡ 35e59de0-fb24-43e6-8e71-c62b01c66dbc
if section_class == :F2
	p1 = md"### 1. Yielding"
	p2 = md"### 2. Lateral Torsional Buckling"
	p3 = md""
	p4 = md""
	@handcalcs begin 
		(;M_p, L_p, L_r, F_cr) = Flexure.F2.calc_variables(w, L_b)
	end
elseif section_class == :F3
	p1 = md"### 1. Lateral Torsional Buckling"
	p2 = md"### 2. Compression Flange Local Buckling"
	p3 = md""
	p4 = md""
	@handcalcs begin 
		(;M_p, L_p, L_r, F_cr, k_c) = Flexure.F3.calc_variables(w, L_b)
	end len= :long
elseif section_class == :F4
	p1 = md"### 1. Compression Flange Yielding"
	p2 = md"### 2. Lateral Torsional Buckling"
	p3 = md"### 3. Compression Flange Local Buckling"
	p4 = md"### 4. Tension Flange Yielding"
	@handcalcs begin 
		(;M_p, M_yc, M_yt, k_c, F_cr, F_L, L_p, L_r, R_pc, R_pt) = Flexure.F4.calc_variables(w, L_b, λ_w, λ_pw, λ_rw)
	end
else
	p1 = md"### 1. Compression Flange Yielding"
	p2 = md"### 2. Lateral Torsional Buckling"
	p3 = md"### 3. Compression Flange Local Buckling"
	p4 = md"### 4. Tension Flange Yielding"
	@handcalcs begin
	(;M_p, R_pg, F_crLTB, F_crCFLB) = Flexure.F5.calc_variables(w, L_b, λ_f, λ_pf, λ_rf, λ_fclass)
	end
end

# ╔═╡ 51f64402-6f11-473d-b8cc-5413755afd49
p1

# ╔═╡ 13c498b5-b029-45e3-b4c5-41a623b4e653
if section_class == :F2
	@handcalcs begin 
		M_n1 = Chf.F2.calc_MnFY(M_p)
	end
elseif section_class == :F3
	@handcalcs begin 
		M_n1 = Chf.F3.calc_MnLTB(M_p, F_y, S_x, F_cr, L_b, L_p, L_r)
	end len=:long
elseif section_class == :F4
	@handcalcs begin 
		M_n1 = Chf.F4.calc_MnCFY(R_pc, M_yc)
	end len=:long
else
	@handcalcs begin 
		M_n1 = Chf.F5.calc_MnCFY(M_p)
	end
end

# ╔═╡ 943ab848-5503-40a1-93dc-7f5554d00eed
p2

# ╔═╡ 38e78ac9-b1dd-4dd4-a302-357c637715f1
if section_class == :F2
	@handcalcs begin 
		M_n2 = Chf.F2.calc_MnLTB(M_p, F_y, S_x, F_cr, L_b, L_p, L_r)
	end len=:long
elseif section_class == :F3
	@handcalcs begin 
		M_n2 = Chf.F3.calc_MnCFLB(M_p, E, F_y, S_x, k_c, λ_f, λ_pf, λ_rf, λ_fclass)
	end
elseif section_class == :F4
	@handcalcs begin 
		M_n2 = Chf.F4.calc_MnLTB(M_p, R_pc, M_yc, F_L, S_x, F_cr, L_b, L_p, L_r)
	end
else
	@handcalcs begin 
		M_n2 = Chf.F5.calc_MnLTB(R_pg, F_crLTB, S_x)
	end
end

# ╔═╡ dd663dc2-ac32-46dd-8aa4-36f9144eef76
p3

# ╔═╡ 309b20c2-8fe1-4f5c-a2e6-d4d27776903a
if section_class == :F2
	M_n3 = M_p
	nothing
elseif section_class == :F3
	M_n3 = M_p
	nothing
elseif section_class == :F4
	@handcalcs begin 
		M_n3 = Chf.F4.calc_MnCFLB(M_p, R_pc, M_yc, F_L, S_x, E, k_c, λ_f, λ_pf, λ_rf, λ_fclass)
	end
else
	@handcalcs begin 
		M_n3 = Chf.F5.calc_MnCFLB(R_pg, F_crCFLB, S_x)
	end
end

# ╔═╡ 5fc2d565-0edd-4e55-86ea-a342bf2b6aed
p4

# ╔═╡ 08fc9b39-5910-4760-9cb0-14505f88ab15
if section_class == :F2
	M_n4 = M_p
	nothing
elseif section_class == :F3
	M_n4 = M_p
	nothing
elseif section_class == :F4
	@handcalcs begin 
		M_n4 = Chf.F4.calc_MnTFY(M_p, R_pt, M_yt, S_x, S_x)
	end
else
	@handcalcs begin 
		M_n4 = Chf.F5.calc_MnTFY(F_y, S_x)
	end
end

# ╔═╡ 20fa8d0b-3223-48ff-9dc2-1fe4dbadedbe
md"### Flexure Capacity"

# ╔═╡ a0b5b142-6f8a-4662-b8b9-dbbf90ab5f73
if section_class == :F2
	@handcalcs begin ϕM_n = ϕ_b*min(M_n1, M_n2) end
elseif section_class == :F3
	@handcalcs begin ϕM_n = ϕ_b*min(M_n1, M_n2) end
elseif section_class == :F4
	@handcalcs begin ϕM_n = ϕ_b*min(M_n1, M_n2, M_n3, M_n4) end
else
	@handcalcs begin ϕM_n = ϕ_b*min(M_n1, M_n2, M_n3, M_n4) end
end

# ╔═╡ 062bee62-420c-4e34-b74e-8e6420fa037f
md"## Reporting"

# ╔═╡ 103caf9f-123d-470d-8141-3739f60cd6df
md"""
You can create reports with this tool as well. See [here](https://github.com/co1emi11er2/Handcalcs.jl/blob/master/examples/aisc_example.pdf) for an example that was made using quarto.

There currently isn't a great way to integrate Quarto and Pluto. It is best to use Jupyter or a qmd file at the moment. Hopefully Pluto will get better integration in the future.
"""

# ╔═╡ 7a6a87b5-d6b3-40e3-828f-c4c9a5720ebf
md"# Thank you"

# ╔═╡ 8b234519-539d-4774-b18f-2f65377606c6
md"Thank you for taking your time to read about Handcalcs.jl. I hope you find the package useful. Feel free to contact me through Github at the [Handcalcs Github Page](https://github.com/co1emi11er2/Handcalcs.jl) if you have any questions or find any bugs!"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AISCSteel = "599de4a1-440e-403d-8b33-ce14758023a2"
Format = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
Handcalcs = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Revise = "295af30f-e4ad-537b-8983-00126c2a3abe"
StructuralUnits = "ec81c399-378c-4a82-baa1-80fb2fc85b6c"
TestHandcalcFunctions = "6ba57fb7-81df-4b24-8e8e-a3885b6fcae7"

[compat]
AISCSteel = "~0.1.0"
Format = "~1.3.7"
Handcalcs = "~0.4.3"
LaTeXStrings = "~1.4.0"
Plots = "~1.40.9"
PlutoUI = "~0.7.60"
Revise = "~3.6.4"
StructuralUnits = "~0.2.0"
TestHandcalcFunctions = "~0.2.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.7"
manifest_format = "2.0"
project_hash = "bbf4e19e2a54f0b4f4ec6fdbf49f56970245584a"

[[deps.AISCSteel]]
deps = ["CSV", "DataFramesMeta", "EnumX", "StructuralUnits"]
git-tree-sha1 = "bd22c09c9fd76532574ecb143d8fc70eb8475cde"
uuid = "599de4a1-440e-403d-8b33-ce14758023a2"
version = "0.1.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "8873e196c2eb87962a2048b3b8e08946535864a1"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+2"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "deddd8725e5e1cc49ee205a1964256043720a6c3"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.15"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.Chain]]
git-tree-sha1 = "9ae9be75ad8ad9d26395bf625dea9beac6d519f1"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.6.0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "c785dfb1b3bfddd1da557e861b919819b82bbe5b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.27.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "64e15186f0aa277e174aa81798f7eb8598e0157e"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "f36e5e8fdffcb5646ea5da81495a5a7566005127"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.3"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "fb61b4812c49343d7ef0b533ba982c46021938a6"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.7.0"

[[deps.DataFramesMeta]]
deps = ["Chain", "DataFrames", "MacroTools", "OrderedCollections", "Reexport", "TableMetadataTools"]
git-tree-sha1 = "21a4335f249f8b5f311d00d5e62938b50ccace4e"
uuid = "1313f7d8-7da2-5740-9ea0-a2ca25f37964"
version = "0.15.4"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e51db81749b0777b2147fbe7b783ee79045b8e99"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.4+1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "7878ff7172a8e6beedd1dea14bd27c3c6340d361"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.22"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "21fac3c77d7b5a9fc03b0ec503aa1a6392c34d2b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.15.0+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "786e968a8d2fb167f2e4880baba62e0e26bd8e4e"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.3+1"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "532f9126ad901533af1d4f5c198867227a7bb077"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+1"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "52adc6828958ea8a0cf923d53aa10773dbca7d5f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.9"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4e9e2966af45b06f24fd952285841428f1d6e858"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.9+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "48b5d4c75b2c9078ead62e345966fa51a25c05ad"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.2+1"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "01979f9b37367603e2848ea225918a3b3861b606"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+1"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "627fcacdb7cb51dc67f557e1598cdffe4dda386d"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.14"

[[deps.Handcalcs]]
deps = ["AbstractTrees", "CodeTracking", "InteractiveUtils", "LaTeXStrings", "Latexify", "MacroTools", "PrecompileTools", "Revise", "TestHandcalcFunctions"]
git-tree-sha1 = "2fd00beb76e82ad724b6593e5ea0f163881783ba"
uuid = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
version = "0.4.3"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "55c53be97790242c29031e5cd45e8ac296dadda3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.0+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InlineStrings]]
git-tree-sha1 = "45521d31238e87ee9f9732561bfee12d4eebd52d"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.2"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "71b48d857e86bf7a1838c4736545699974ce79a2"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.9"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "be3dc50a92e5a386872a493a10050136d4703f9b"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "25ee0be4d43d0269027024d75a24c24d6c6e590c"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.4+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "10da5154188682e5c0726823c2b5125957ec3778"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.38"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "36bdbc52f13a7d1dcb0f3cd694e01677a515655b"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.0+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "854a9c268c43b77b0a27f22d7fab8d33cdb3a731"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+1"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "ff3b4b9d35de638936a525ecd36e86a8bb919d11"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c6ce1e19f3aec9b59186bdf06cdf3c4fc5f5f3e6"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.50.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "61dfdba58e585066d8bce214c5a51eaa0539f269"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "84eef7acd508ee5b3e956a2ae51b05024181dee0"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.2+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "b404131d06f7886402758c9ce2214b636eb4d54a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "edbf5309f9ddf1cab25afc344b1e8150b7c832f9"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.2+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "688d6d9e098109051ae33d126fcfc88c4ce4a021"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.1.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7493f61f55a6cce7325f197443aa80d32554ba10"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.15+1"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "12f1439c4f986bb868acda6ea33ebc78e19b95ad"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.7.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e127b609fb9ecba6f201ba7ab753d5a605d53801"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.54.1+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "dae01f8c2e069a683d3a6e17bbae5070ab94786f"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.9"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "492601870742dcd38f233b23c3ec629628c1d724"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.7.1+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "e5dd466bf2569fe08c91a2cc29c1003f4797ac3b"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.7.1+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "1a180aeced866700d4bebc3120ea1451201f16bc"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.7.1+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "729927532d48cf79f49070341e1d918a65aba6b0"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.7.1+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "470f48c9c4ea2170fd4d0f8eb5118327aada22f5"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.6.4"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "83e6cce8324d49dfaf9ef059227f91ed4441a8e5"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "29321314c920c26684834965ec2ce0dacc9cf8e5"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.4"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a6b1675a536c5ad1a60e5a5153e1fee12eb146e3"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.0"

[[deps.StructuralUnits]]
deps = ["Reexport", "Unitful", "UnitfulLatexify"]
git-tree-sha1 = "0e2a61508c26a096c3c032a55f9f997b13011b59"
uuid = "ec81c399-378c-4a82-baa1-80fb2fc85b6c"
version = "0.2.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableMetadataTools]]
deps = ["DataAPI", "Dates", "TOML", "Tables", "Unitful"]
git-tree-sha1 = "c0405d3f8189bb9a9755e429c6ea2138fca7e31f"
uuid = "9ce81f87-eacc-4366-bf80-b621a3098ee2"
version = "0.1.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TestHandcalcFunctions]]
git-tree-sha1 = "54dac4d0a0cd2fc20ceb72e0635ee3c74b24b840"
uuid = "6ba57fb7-81df-4b24-8e8e-a3885b6fcae7"
version = "0.2.4"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "01915bfcd62be15329c9a07235447a89d588327c"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.21.1"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "a2fccc6559132927d4c5dc183e3e01048c6dcbd6"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.5+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "7d1671acbe47ac88e981868a078bd6b4e27c5191"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.42+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "15e637a697345f6743674f1322beefbc5dcd5cfc"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.6.3+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "326b4fea307b0b39892b3e85fa451692eda8d46c"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.1+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "3796722887072218eabafb494a13c963209754ce"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "9dafcee1d24c4f024e7edc92603cedba72118283"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+1"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2b0e27d52ec9d8d483e2ca0b72b3cb1a8df5c27a"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+1"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "02054ee01980c90297412e4c809c8694d7323af3"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+1"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d7155fea91a4123ef59f42c4afb5ab3b4ca95058"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+1"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a1a7eaf6c3b5b05cb903e35e8372049b107ac729"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.5+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "b6f664b7b2f6a39689d822a6300b14df4668f0f4"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.4+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a490c6212a0e90d2d55111ac956f7c4fa9c277a6"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+1"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee57a273563e273f0f53275101cd41a8153517a"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+1"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "1a74296303b6524a0472a8cb12d3d87a78eb3612"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+1"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "dbc53e4cf7701c6c7047c51e17d6e64df55dca94"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+1"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "ab2221d309eda71020cdda67a973aa582aa85d69"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+1"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b9ead2d2bdb27330545eb14234a2e300da61232e"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+1"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "555d1076590a6cc2fdee2ef1469451f872d8b41b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6e50f145003024df4f5cb96c7fce79466741d601"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.56.3+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0ba42241cb6809f1a278d0bcb976e0483c3f1f2d"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+1"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "b70c870239dc3d7bc094eb2d6be9b73d27bef280"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.44+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╠═12d41162-b9aa-11ef-33d9-a32698d6f054
# ╠═5ac917a4-79bf-419e-9eff-6501c2d15d28
# ╟─bd811c3e-6802-4c5a-9904-9e6044c976be
# ╟─a8bb7d69-55a4-4381-aa98-b2169d3064d7
# ╟─897f866e-40ef-4c47-993e-40f58f8c340b
# ╟─98ec50cc-dddf-48ac-9806-990a9e2e334a
# ╟─18eded2b-f973-4a61-9754-56331fd01336
# ╠═ba51899c-61d6-440d-8263-d479f6a871f6
# ╟─a2758980-252e-4e6b-baf3-a5a6e85df34d
# ╟─27b55f64-358e-4bc2-a5f4-315ea361b646
# ╠═0eac9a5a-c6a8-43e9-99c9-16f7c3d77204
# ╠═00e75249-8d2c-4407-9564-68c8d79fc29f
# ╟─2a7e9993-74f9-48f8-964b-e858e3b96672
# ╠═3589a61a-84a2-4413-9fb9-3454105f6df2
# ╟─f3a4d941-fcd4-421b-94e4-2d486e71da12
# ╟─69f31cc2-af12-4a8c-bbf1-9959f9d78b4f
# ╠═79f4fb1c-e512-4af6-835c-ea0865d80c5e
# ╟─cd4ab653-0627-44e4-8b58-c475e0a0a251
# ╟─99730005-9dca-48aa-a409-5b0438660220
# ╟─6633dd4a-2b68-4127-90ed-9e4caab68f56
# ╟─c0a250de-36dd-4647-9281-c237e9efd359
# ╠═b5c7a277-da51-487b-869e-1936816017ac
# ╠═54ea2e03-ab01-4371-a13d-c3de13876c10
# ╠═ef8baa5a-90ef-4a67-94bc-40d6c50abe74
# ╟─ec3681b3-7c95-4c4e-8320-89f535440d92
# ╠═1c5ec9af-8f8b-416d-ad76-aec0af292895
# ╟─20503429-f22b-49b0-9f06-3ffcfc811a93
# ╠═fd00ab45-3967-4159-88a3-e6a924be40bc
# ╟─350d438e-1cfa-4c4c-85ff-afdfecfc171e
# ╠═43633b23-b5cd-45ad-893f-ecd766726610
# ╟─778b64c5-6a06-4e74-8da6-67a83f08eac5
# ╠═4b8d463f-b186-4d1f-9b80-62ff7a5a886d
# ╟─24c12e97-4090-48a4-8c66-bb5d2068e1e4
# ╟─3867ea24-0e62-46bf-84e3-b86bc3e74ae7
# ╟─ad2ea96b-4b87-49ed-bd5e-37aca4f8973d
# ╟─bec7dfa6-8787-45b7-b2cb-230666712a3f
# ╠═5dd3bce5-9f12-480d-9000-ec84766c18be
# ╟─07ff6778-df02-4dc1-81ba-661afaec6320
# ╠═b2237f22-b523-4f71-b196-85e1fdddb393
# ╟─740bda9e-8191-447b-ba1d-e5a8784fca84
# ╟─42e089cd-1ec2-4924-ac4a-d42d18c9c68a
# ╟─3f2d9d3e-82f9-4cc7-bf06-18bd33dde4c0
# ╟─081762c8-3109-438a-abd4-17f20c7db455
# ╠═4b9ff29b-d777-4694-926a-5c95851e81e7
# ╟─7c09b665-e48b-4825-bd75-4540ba12afeb
# ╟─9d6f3c2a-fe77-4712-94b5-1dd9c61edc22
# ╟─e266ab7d-21a6-4f91-a229-102e27a4e68d
# ╠═bdb88b43-7c4f-48a8-b6b5-0130cf5f402a
# ╟─8a0028f1-1d1d-4448-a20a-9bc25b17e02c
# ╟─c2252cdb-4151-4a2a-b421-2e808bb26883
# ╟─5ba38942-a676-40a7-9d9c-821f76d642d6
# ╟─a7064738-e518-42c6-9aa8-f8bc2e013f2d
# ╟─fdee2c0c-add7-4e08-a307-9259711a61b1
# ╟─eed9bbf2-8993-4df6-a7fd-243e5169c8dd
# ╠═cae8c270-c620-4bb4-9175-a8702e7ed7ab
# ╟─419375f5-1f14-465e-8d3f-3c7fd5664166
# ╟─4b33c7b8-460e-4248-bbb6-58ebe434fa0c
# ╟─73050a9f-3938-4d90-b7d6-e145ae7c6a9d
# ╠═1a2b22b3-b730-4475-85cb-ec284ae1612c
# ╟─f827503c-ef71-48e1-9e54-c46afd810bed
# ╠═1cc8d792-6850-490c-bc1a-12c1059acf1b
# ╠═089d48f6-76fa-4610-a007-c18246ef25cb
# ╠═209b7fc9-a06a-43de-9400-fa6537d4350c
# ╟─1ee5a282-0919-4e2a-982a-845a89de384d
# ╟─083d1e86-90da-4e54-adbb-06939a665c3f
# ╟─bf97f95b-860b-4367-b5bd-6081c384dd40
# ╟─5cec6944-201d-498e-b2e1-6844c8c56d2b
# ╟─2d322e46-9b1b-44d2-9a93-9dea65945768
# ╟─08701b61-f7a5-4e0e-9844-254c331f2276
# ╠═536885c8-73d7-47ab-9b79-6071391d5710
# ╟─01cd1817-7493-4c4e-908d-0fba32860bb4
# ╟─29bbc01a-c3e4-44b1-94ee-a7ec102308c0
# ╠═5eb052e9-5f8c-4502-8ac3-7ab87bab1361
# ╟─f12e06f8-1dfc-4e04-bd9a-1da1d733fe56
# ╟─ad759d44-ab32-4ca8-b7e7-664720df987d
# ╟─9c734a4d-afc0-42ba-91e7-4044b40d8032
# ╟─208b1627-8bc3-48ae-b150-6d4ad63a475b
# ╟─35e59de0-fb24-43e6-8e71-c62b01c66dbc
# ╟─51f64402-6f11-473d-b8cc-5413755afd49
# ╟─13c498b5-b029-45e3-b4c5-41a623b4e653
# ╟─943ab848-5503-40a1-93dc-7f5554d00eed
# ╟─38e78ac9-b1dd-4dd4-a302-357c637715f1
# ╟─dd663dc2-ac32-46dd-8aa4-36f9144eef76
# ╟─309b20c2-8fe1-4f5c-a2e6-d4d27776903a
# ╟─5fc2d565-0edd-4e55-86ea-a342bf2b6aed
# ╟─08fc9b39-5910-4760-9cb0-14505f88ab15
# ╟─20fa8d0b-3223-48ff-9dc2-1fe4dbadedbe
# ╟─a0b5b142-6f8a-4662-b8b9-dbbf90ab5f73
# ╟─062bee62-420c-4e34-b74e-8e6420fa037f
# ╟─103caf9f-123d-470d-8141-3739f60cd6df
# ╟─7a6a87b5-d6b3-40e3-828f-c4c9a5720ebf
# ╟─8b234519-539d-4774-b18f-2f65377606c6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
