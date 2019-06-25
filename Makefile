NAME = lem-in


LIBFT_DIR = ./libft/
LIBFT := $(addprefix $(LIBFT_DIR), libft.a)
INC_DIR = $(LIBFT_DIR)includes/ ./includes/ $(LIBMLX_DIR)

CC = gcc
CC_FLAGS = -W -Wall -Werror -Wextra
:w
T_BLK = \033[5m
T_NRM = \033[25m
C_GRN = \033[32m
C_YLW = \033[33m
C_BLU = \033[34m
C_LGRN = \033[92m
C_LYLW = \033[93m
C_LBLU = \033[54m
C_LMGN = \033[95m
C_END = \033[0m

LEMIN := lem-in.c

UTILS :=

SRC_FILES := $(addprefix lemin/,  $(LEMIN)) \
    $(addprefix utils/,  $(UTILS))

SRC_DIR := ./src/
SRC := $(addprefix $(SRC_DIR), $(SRC_FILES))

NB = $(words $(SRC_FILES))
IND = 0
PER = 0

OBJ := $(SRC:.c=.o)

all: $(NAME) $(GUI_NAME)

$(NAME): $(LIBFT)
	@echo "$(C_LYLW)➜ [$(NAME)] Compiling objects ...$(C_END)"
	@make $(OBJ)
	@echo "\033[1A$(T_CLR)$(C_LGRN)➜ [$(NAME)] Objects have been compiled successfully ! $(C_END)"
	@$(CC) $(CC_FLAGS) $(OBJ) $(LIBFT) -ltermcap -o $(NAME)
	@echo "$(C_LGRN)➜ [$(NAME)] The program $(C_LBLU)$(NAME)$(C_LGRN)\
	 has been Compiled Successfully !$(C_END)"

$(OBJ): %.o: %.c  $(LIBFT)
	@$(CC) $(CC_FLAGS) -c $< -o $@ $(addprefix -I , $(INC_DIR))
	@$(eval IND=$(shell echo $$(($(IND) + 1))))
	@$(eval PER=$(shell echo $$((($(IND) * 100) / $(NB)))))
	@printf "$(T_CLR)$(C_LYLW)➜ ➜ progress: %3d %% $(C_END)\n\033[1A$(C_END)" $(PER);

$(LIBFT):
	@make -C $(LIBFT_DIR)
	@echo "$(C_LYLW)=================================================\
	===================$(C_END)"

clean:
	@make clean -C $(LIBFT_DIR)
	@rm -f $(OBJ)
	@echo "$(C_LMGN)➜ [$(NAME)] Objects have been cleaned\
	 Successfully !$(C_END)"

fclean: clean
	@rm -f $(NAME)
	@make fclean -C $(LIBFT_DIR)
	@echo "$(C_LMGN)➜ [$(NAME)] The Executable has been deleted\
	 Successfully !$(C_END)"

re: fclean all
	@echo "$(C_LGRN)➜ [$(NAME)] The Program has been re-builded\
	 Successfully !$(C_END)"

norm:
	@norminette -R CheckForbiddenSourceHeader $(SRC) $(INC)
	@make norm -C $(LIBFT_DIR)

quick: clean
	@rm $(NAME) & make $(NAME)
	@echo "READY !!!"

.PHONY: all, re, clean, fclean, norm
