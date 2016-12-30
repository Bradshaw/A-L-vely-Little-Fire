extern float samples = 16;
extern float dist = 0.05;

float gauss(float x){
	return exp(-(x*x)*8);
}

vec4 blurh(Image texture, vec2 texture_coords){
	vec4 col = vec4(0,0,0,1);
	for (int i = -10; i <= 10; i+=1){
		float d = i/samples;
		float g = gauss(d);
		col += g*4*Texel(texture, texture_coords+vec2(d*dist,0));
	}
	col/=(samples*2)+1;
	col.a = 1;
	return col;
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	return blurh(texture, texture_coords);
}


vec4 position( mat4 transform_projection, vec4 vertex_position )
{
	return transform_projection * vertex_position;
}