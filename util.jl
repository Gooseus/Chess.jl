# util.jl


function clear_repl()
    print("\033[2J")  # clear screen
    height = displaysize(STDOUT)[1]
    print("\033[$(height)A") # set cursor at the top of the display
end

function square(c::Integer, r::Integer)
    sqr = UInt64(1) << ((c-1) + 8*(r-1))
    sqr
end

function column_row(sqr::UInt64)
    square_index = Integer(log2(sqr))
    # n.b. ÷ gives integer quotient like div()
    row = (square_index-1)÷8 + 1
    column = ((square_index-1) % 8) + 1
    (column,row)
end

function square_name(sqr::UInt64)
    file_character = ' '
    if sqr & FILE_A > 0  file_character = 'a'  end
    if sqr & FILE_B > 0  file_character = 'b'  end
    if sqr & FILE_C > 0  file_character = 'c'  end
    if sqr & FILE_D > 0  file_character = 'd'  end
    if sqr & FILE_E > 0  file_character = 'e'  end
    if sqr & FILE_F > 0  file_character = 'f'  end
    if sqr & FILE_G > 0  file_character = 'g'  end
    if sqr & FILE_H > 0  file_character = 'h'  end
    rank_character = ' '
    if sqr & RANK_1 > 0  rank_character = '1'  end
    if sqr & RANK_2 > 0  rank_character = '2'  end
    if sqr & RANK_3 > 0  rank_character = '3'  end
    if sqr & RANK_4 > 0  rank_character = '4'  end
    if sqr & RANK_5 > 0  rank_character = '5'  end
    if sqr & RANK_6 > 0  rank_character = '6'  end
    if sqr & RANK_7 > 0  rank_character = '7'  end
    if sqr & RANK_8 > 0  rank_character = '8'  end
    "$file_character$rank_character"
end

function square_name(sqrs::Array{UInt64,1})
    output = ""
    for s in sqrs
        output = output * square_name(s) * " "
    end
    output
end

#CHARACTERS = ['k','q','r','b','n','p']
const CHARACTERS = ['♔','♕','♖','♗','♘','♙']
function character_for_piece(color, piece)
    if piece==0
        return CHARACTER_SQUARE_EMPTY
    end

    s = CHARACTERS[piece]
    if color==WHITE
        s = s + 6
    end
    s
end

@inline function Base.count(bit_mask::UInt64)
    count(i->i=='1', bits(bit_mask))
end
