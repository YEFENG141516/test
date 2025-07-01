import tkinter as tk
from tkinter import messagebox

class GobangGame:
    def __init__(self, root):
        self.root = root
        self.root.title("五子棋游戏")
        self.is_game_started = False
        self.current_player = "black"  # 黑方先行
        self.board_size = 15
        self.cell_size = 40
        self.canvas_width = self.board_size * self.cell_size
        self.canvas_height = self.board_size * self.cell_size
        self.pieces = {}  # 存储棋子位置和颜色，键为坐标元组，值为颜色
        self.win_line = []  # 存储获胜的五个棋子坐标
        self.move_history = []  # 记录落子历史，用于悔棋

        # 创建主界面
        self.create_main_interface()

    def create_main_interface(self):
        # 清除现有界面
        for widget in self.root.winfo_children():
            widget.destroy()

        # 创建开始和退出按钮
        start_button = tk.Button(self.root, text="开始游戏", command=self.start_game, width=20, height=2)
        start_button.pack(pady=20)

        quit_button = tk.Button(self.root, text="退出游戏", command=self.root.quit, width=20, height=2)
        quit_button.pack(pady=10)

    def start_game(self):
        # 清除现有界面
        for widget in self.root.winfo_children():
            widget.destroy()

        # 创建游戏画布
        self.canvas = tk.Canvas(self.root, width=self.canvas_width, height=self.canvas_height, bg="#F0D9B5")
        self.canvas.pack(padx=10, pady=10)

        # 绘制棋盘网格
        for i in range(self.board_size):
            # 水平线
            self.canvas.create_line(
                self.cell_size / 2,
                self.cell_size / 2 + i * self.cell_size,
                self.canvas_width - self.cell_size / 2,
                self.cell_size / 2 + i * self.cell_size,
                width=1
            )
            # 垂直线
            self.canvas.create_line(
                self.cell_size / 2 + i * self.cell_size,
                self.cell_size / 2,
                self.cell_size / 2 + i * self.cell_size,
                self.canvas_height - self.cell_size / 2,
                width=1
            )

        # 绘制五个星位
        star_points = [(3, 3), (3, 11), (7, 7), (11, 3), (11, 11)]
        for x, y in star_points:
            cx = self.cell_size / 2 + x * self.cell_size
            cy = self.cell_size / 2 + y * self.cell_size
            self.canvas.create_oval(cx - 3, cy - 3, cx + 3, cy + 3, fill="black")

        # 创建当前玩家指示器
        self.player_label = tk.Label(self.root, text="当前玩家: 黑方", font=("SimHei", 12))
        self.player_label.pack(pady=5)

        # 绑定鼠标点击事件（现在黑白子都用左键）
        self.canvas.bind("<Button-1>", self.place_piece)

        # 游戏状态变量初始化
        self.is_game_started = True
        self.current_player = "black"
        self.pieces = {}
        self.win_line = []
        self.move_history = []  # 清空历史记录

        # 创建悔棋和返回主菜单按钮
        button_frame = tk.Frame(self.root)
        button_frame.pack(pady=5)

        undo_button = tk.Button(button_frame, text="悔棋", command=self.undo_move, width=10, height=1)
        undo_button.pack(side=tk.LEFT, padx=5)

        back_button = tk.Button(button_frame, text="返回主菜单", command=self.create_main_interface, width=15, height=1)
        back_button.pack(side=tk.LEFT, padx=5)

    def place_piece(self, event):
        if not self.is_game_started:
            return

        # 计算最近的交叉点
        x, y = self.get_board_coordinates(event.x, event.y)

        # 检查是否在有效范围内且该位置没有棋子
        if 0 <= x < self.board_size and 0 <= y < self.board_size and (x, y) not in self.pieces:
            # 放置当前玩家的棋子
            color = self.current_player
            self.place_piece_on_board(x, y, color)

    def get_board_coordinates(self, screen_x, screen_y):
        # 计算鼠标点击位置对应的棋盘坐标
        x = round((screen_x - self.cell_size / 2) / self.cell_size)
        y = round((screen_y - self.cell_size / 2) / self.cell_size)
        return x, y

    def place_piece_on_board(self, x, y, color):
        # 在画布上绘制棋子
        cx = self.cell_size / 2 + x * self.cell_size
        cy = self.cell_size / 2 + y * self.cell_size
        radius = self.cell_size / 2 - 2
        piece_id = self.canvas.create_oval(
            cx - radius, cy - radius, cx + radius, cy + radius,
            fill=color, outline="black" if color == "white" else ""
        )

        # 记录棋子位置和颜色
        self.pieces[(x, y)] = (color, piece_id)

        # 记录落子历史（用于悔棋）
        self.move_history.append((x, y, color, piece_id))

        # 检查是否有玩家获胜
        if self.check_win(x, y, color):
            self.highlight_win_line()
            winner = "黑方" if color == "black" else "白方"
            messagebox.showinfo("游戏结束", f"{winner}获胜！")
            self.is_game_started = False
            return

        # 切换当前玩家
        self.current_player = "white" if color == "black" else "black"
        self.player_label.config(text=f"当前玩家: {'黑方' if self.current_player == 'black' else '白方'}")

    def check_win(self, x, y, color):
        directions = [
            (1, 0),   # 水平
            (0, 1),   # 垂直
            (1, 1),   # 右下对角线
            (1, -1)   # 右上对角线
        ]

        for dx, dy in directions:
            count = 1  # 当前位置的棋子算一个
            line = [(x, y)]

            # 向正方向检查
            for i in range(1, 5):
                nx, ny = x + dx * i, y + dy * i
                if (nx, ny) in self.pieces and self.pieces[(nx, ny)][0] == color:
                    count += 1
                    line.append((nx, ny))
                else:
                    break

            # 向反方向检查
            for i in range(1, 5):
                nx, ny = x - dx * i, y - dy * i
                if (nx, ny) in self.pieces and self.pieces[(nx, ny)][0] == color:
                    count += 1
                    line.append((nx, ny))
                else:
                    break

            # 如果有五子连珠
            if count >= 5:
                self.win_line = line
                return True

        return False

    def highlight_win_line(self):
        # 高亮显示获胜的五个棋子
        for x, y in self.win_line:
            cx = self.cell_size / 2 + x * self.cell_size
            cy = self.cell_size / 2 + y * self.cell_size
            radius = self.cell_size / 2 - 2
            self.canvas.create_oval(
                cx - radius, cy - radius, cx + radius, cy + radius,
                outline="red", width=3
            )

    def undo_move(self):
        if not self.is_game_started or len(self.move_history) == 0:
            return

        # 移除最后一步落子
        x, y, color, piece_id = self.move_history.pop()
        self.canvas.delete(piece_id)
        del self.pieces[(x, y)]

        # 切换回上一个玩家
        self.current_player = color
        self.player_label.config(text=f"当前玩家: {'黑方' if self.current_player == 'black' else '白方'}")

if __name__ == "__main__":
    root = tk.Tk()
    # 确保中文正常显示
    root.option_add("*Font", "SimHei 10")
    game = GobangGame(root)
    root.mainloop()