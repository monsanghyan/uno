import random
player = int(input())
card = [(i, 'R') for i in range(1, 9)] + [(i, 'Y') for i in range(1, 9)] + [(i, 'B') for i in range(1, 9)] + [(i, 'G') for i in range(1, 9)]
card += [("REVERSE", 'Y'), ("REVERSE", 'Y'), ("REVERSE", 'R'), ("REVERSE", 'R'), ("REVERSE", 'B'), ("REVERSE", 'B'), ("REVERSE", 'G'),("REVERSE", 'G')]
card += [("+2", "Y"), ("+2", "Y"), ("+2", "B"), ("+2", "B"), ("+2", "R"), ("+2", "R"), ("+2", "G"), ("+2", "G")]
card += [("BAN", "Y"), ("BAN", "Y"), ("BAN", "B"), ("BAN", "B"), ("BAN", "R"), ("BAN", "R"), ("BAN", "G"), ("BAN", "G")]
card += [["CHANGE", 'BLACK'] for _ in range(4)] + [("+4", 'BLACK') for i in range(4)]
random.shuffle(card)
table = [[card.pop() for i in range(7)], [card.pop() for i in range(7)], [card.pop() for i in range(7)], [card.pop() for i in range(7)]]

set_on = card.pop()
x = 0
stack = 0
while True:

    # 다 없을때 게임끝
    if not table[0] or not table[1] or not table[2] or not table[3]:
        break

    # 현재 카드
    print(set_on)

    play = table[x%4]


    if set_on[0] == '+2':
        stack += 2
    elif set_on[0] == '+4':
        stack += 4
    while True:
        # 제출 방법
        print(play)
        submit = int(input('카드를 선택해 주세요(위치번호), (없으면 0): '))

        # 스텍이 있으면 못낼 시 먹음
        if stack:
            if play[submit-1][0] != '+2' and play[submit-1][0] != '+4':
                play += [card.pop() for i in range(stack-1)]
                stack = 0
                break


        # 없으면 먹기
        if submit == 0:
            play.append(card.pop())
            break

        # 범위 제한
        if submit > len(play):
            print('범위를 벗어났습니다.')
            continue

        # 제출 가능 여부 확인
        up = play[submit-1]
        if set_on[0] != up[0] and set_on[1] != up[1]:
            if up[1] != 'BLACK' and set_on[1] != 'BLACK':
                print('제출불가')
                continue
        set_on = up
        wp = play.pop(submit-1)

        # 색깔 바꾸기 카드
        if wp == "CHANGE":
            while True:
                color = input("R/B/G/Y")
                if color != 'R' and color != 'B' and color != 'G' and color != 'Y':
                    print('다시 입력하세요')
                    continue
                break
            set_on[1] = color
        break
    x += 1

if not table[0]:
    print("player1 victory")
elif not table[1]:
    print("player2 victory")
elif not table[2]:
    print("player3 victory")
elif not table[3]:
    print("player4 victory")
