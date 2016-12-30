vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	vec4 col = Texel(texture, texture_coords)*color;
	col.r = 1-col.r;
	col.g = 1-col.g;
	col.b = 1-col.b;

	return col;
}

vec4 position( mat4 transform_projection, vec4 vertex_position )
{
	return transform_projection * vertex_position;
}