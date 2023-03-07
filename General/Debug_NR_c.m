current_patch = [99 101 102 
201 101 194 
102 100 98];
match_patch1 = [100 113 101 
190 98 202 
102 98 99 ];
match_patch2 = [101 105 104 
202 101 195 
99 101 102 ];
match_patch3 = [104 107 110 
195 102 200 
102 97 93 ];
match_patch4 = [102 98 99 
199 105 201 
104 101 102 ];
match_patch5 = [102 97 93 
194 96 208 
98 98 110 ];
match_patch6 = [104 101 102 
191 102 195 
97 99 101 ];
match_patch7 = [102 100 98 
195 96 195 
101 103 99 ];
match_patch8 = [98 98 110 
195 98 202 
99 102 98 ];

delt_patch_sad = sum(sum((current_patch - match_patch1).^2));