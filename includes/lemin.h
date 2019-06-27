
#ifndef LEMIN_H
# define LEMIN_H

typedef struct	s_lemin
{
	int nants;
}				t_lemin;

int				li_parse(t_lemin *lemin);

int				li_solve(t_lemin *lemin);

#endif
