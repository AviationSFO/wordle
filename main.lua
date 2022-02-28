--[[
    Wordle Clone made with lua
    By Steven Weinstein on 2-28-2022
]]

local function noSpace(str)
    local normalisedString = string.gsub(str, "%s+", "")
    return normalisedString
end
os.execute("cd ~/Desktop")
os.execute("clear")
-- reading available words from file
local dir = os.getenv("PWD") or io.popen("cd"):read()
dir = dir .. "/wordle/words.txt"
-- print(dir)
local file = io.open(dir, "r")
local words = {}
local wrongchars = {}
for i = 1, 2315 do
    words[#words+1] = file:read("*l")
    words[#words] = noSpace(words[#words])
end
file:close()
-- opening statment
print("Wordle created by Steven Weinstein Version v0.1dev.")

-- defining reused functions as part of loading
local function split (inputstr)
    local t = {}
    local str = inputstr
    
    for i=1, string.len(str) do
      t[i]= (string.sub(str,i,i))
    end
    return t
end
local function tablecontains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
  end
-- generates random word as the one to guess
local function generateword()
    local randnum = math.random(1,2315)
    local randword = words[randnum]
    randword = string.gsub(randword, " ", "")
    return randword
end
local correct_answer = generateword()
-- checks if word is allowed
local function check_allowed(guess)
    local i = 1
    while true do
        if guess == words[i] then
            return true
        end
        i = i + 1
        if i > #words then
            break
        end
    end
    return false
end


-- let user guess a word
local function guessword()
    local guessing = true
    while guessing == true do
        io.write("Enter your word: ")
        guess = io.read()
        guess = string.lower(guess)
        guess = noSpace(guess)
        if check_allowed(guess) == true then
            guessing = false
            break
        else
            print("Sorry, \'" .. guess .. "\' is not in the allowed words list. Please try agian!")   
        end
    end
    -- now checking positional corectness
    local parsedguess = split(guess)
    local parsedanswer = split(correct_answer)
    local pos1,pos2,pos3,pos4,pos5 = nil,nil,nil,nil,nil
    local v = 1
    --print(parsedguess[1], parsedguess[2], parsedguess[3], parsedguess[4], parsedguess[5])
    while true do
        if string.find(correct_answer, parsedguess[v]) ~= nil then
            if v == 1 then
                pos1 = "yellow"
            elseif v == 2 then
                pos2 = "yellow"
            elseif v == 3 then
                pos3 = "yellow"
            elseif v == 4 then
                pos4 = "yellow"
            elseif v == 5 then
                pos5 = "yellow"
            end
        else
            if tablecontains(wrongchars, parsedguess[v]) then
                found = true
            else
                found = false
                wrongchars[#wrongchars+1] = parsedguess[v]
            end
        end

        if parsedguess[v] == parsedanswer[v] then
            if v == 1 then
                pos1 = "green"
            elseif v == 2 then
                pos2 = "green"
            elseif v == 3 then
                pos3 = "green"
            elseif v == 4 then
                pos4 = "green"
            elseif v == 5 then
                pos5 = "green"
            end
        end
        v = v + 1
        if v > 5 then
            break
        end
    end
    -- print(pos1, pos2, pos3, pos4, pos5)
    if pos1 == "green" and pos2 == "green" and pos3 == "green" and pos4 == "green" and pos5 == "green" then
        print("\27[102;30m" .. guess .. "\27[0m")
        print("Congratulations! You Won!")
        return true
    else
        if pos1 == "green" then
            io.write("\27[102;30m" .. parsedguess[1] .. "\27[0m")
        elseif pos1 == "yellow" then
            io.write("\27[43;30m" .. parsedguess[1] .. "\27[0m")
        else
            io.write("\027[0m")
            io.write(parsedguess[1])
        end
        if pos2 == "green" then
            io.write("\27[102;30m" .. parsedguess[2] .. "\27[0m")
        elseif pos2 == "yellow" then
            io.write("\27[43;30m" .. parsedguess[2] .. "\27[0m")
        else
            io.write("\027[0m")
            io.write(parsedguess[2])
        end
        if pos3 == "green" then
            io.write("\27[102;30m" .. parsedguess[3] .. "\27[0m")
        elseif pos3 == "yellow" then
            io.write("\27[43;30m" .. parsedguess[3] .. "\27[0m")
        else
            io.write("\027[0m")
            io.write(parsedguess[3])
        end
        if pos4 == "green" then
            io.write("\27[102;30m" .. parsedguess[4] .. "\27[0m")
        elseif pos4 == "yellow" then
            io.write("\27[43;30m" .. parsedguess[4] .. "\27[0m")
        else
            io.write("\027[0m")
            io.write(parsedguess[4])
        end
        if pos5 == "green" then
            io.write("\27[102;30m" .. parsedguess[5] .. "\27[0m")
        elseif pos5 == "yellow" then
            io.write("\27[43;30m" .. parsedguess[5] .. "\27[0m")
        else
            io.write("\027[0m")
            io.write(parsedguess[5])
        end
        io.write("\n")
        local p = 1
        io.write("Wrong characters used: ")
        while true do
            io.write(string.upper(wrongchars[p]) .. ", ")
            p = p + 1
            if p > #wrongchars then
                break
            end
        end
        io.write("\n")
    end
end

-- beinging of user interaction
print("\nWelcome to wordle! Press enter to start.")
io.read()
-- print(correct_answer)
-- loop for guessing 6 times
for round = 1, 6, 1 do
    correct = guessword()
    if correct then
        break
    end
end
if correct ~= true then 
    print("You lost. The word was " .. correct_answer .. "!")
end
print("\027[0m")