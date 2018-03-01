defmodule  FacebookApp.Accounts.Idcon do
	alias FacebookApp.Accounts.Image

	# Starts the Identicon generator.
	def gen_idcon_path(input) do
		input
		|> hash_input
		|> pick_color
		|> build_grid
		|> filter_odd_squares
		|> build_pixel_map
		|> draw_image
		|> save_image(input)
	end

	defp save_image(image, input) do
		filename = "assets/static/images/identicons/#{:crypto.hash(:md5, input) |> Base.encode16}.png"
		File.write(filename, image)
		filename
	end

	defp draw_image(%Image{color: color, pixel_map: pixel_map}) do
		image = :egd.create(250, 250)
		fill = :egd.color(color)

		Enum.each pixel_map, fn({start, stop}) ->
			:egd.filledRectangle(image, start, stop, fill)
		end

		:egd.render(image)
	end

	defp build_pixel_map(%Image{grid: grid} = image) do
		pixel_map = Enum.map grid, fn({_code, index}) ->
			horizontal = rem(index, 5) * 50
			vertical = div(index, 5) * 50

			top_left = {horizontal, vertical}
			bottom_right = {horizontal + 50, vertical + 50}

			{top_left, bottom_right}
		end

		%Image{image | pixel_map: pixel_map}
	end

	defp filter_odd_squares(%Image{grid: grid} = image) do
		grid = Enum.filter grid, fn({code, _index}) ->
			rem(code, 2) == 0
		end

		%Image{image | grid: grid}
	end

	defp build_grid(%Image{hex: hex} = image) do
		grid =
			hex
			|> Enum.chunk(3)
			|> Enum.map(&mirror_row/1)
			|> List.flatten
			|> Enum.with_index

		%Image{image | grid: grid}
	end

	def mirror_row(row) do
		[first, second | _tail] = row

		row ++ [second, first]
	end

	defp pick_color(%Image{hex: [r, g, b | _tail]} = image) do
		%Image{image | color: {r, g, b}}
	end

	def hash_input(input) do
		hex = :crypto.hash(:md5, input)
		|> :binary.bin_to_list

		%Image{hex: hex}
	end

end
