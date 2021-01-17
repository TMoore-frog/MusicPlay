script_name('MusicPlay')
script_author('TMoore')
script_version('0.2.5')

require('lib.moonloader')
local as_action = require('moonloader').audiostream_state
local encoding = require('encoding')
local inicfg = require('inicfg')
local vkeys = require('vkeys')
local sampev = require('lib.samp.events')
local imgui = require('imgui')
local inicfg = require('inicfg')
local notify = import('lib_imgui_notf.lua')
local fa = require('faIcons')
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
imgui.ToggleButton = require('imgui_addons').ToggleButton
encoding.default = 'CP1251'
u8 = encoding.UTF8

local mainIni = 'MusicPlay'
local WindowMain = imgui.ImBool(false)
local WindowNewMusic = imgui.ImBool(false)
local NamePesnya = imgui.ImBuffer(256)
local URL = imgui.ImBuffer(512)
local TextError = 0
local Playing = 0

local mainIni = inicfg.load({
    Znachenia=
    {
    Pesn=0,
    NullPesen=0
    },
    Music=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music1=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music2=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music3=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music4=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music5=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music6=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music7=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music8=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music9=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music10=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music11=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music12=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music13=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music14=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music15=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music16=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music17=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music18=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music19=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music20=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music21=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music22=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music23=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music24=
    {
        NamePesnya=u8'',
        URL=u8''
    },
    Music25=
    {
        NamePesnya=u8'',
        URL=u8''
    }
})

local Pesn = mainIni.Znachenia.Pesn
local NullPesen = mainIni.Znachenia.NullPesen

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    sampRegisterChatCommand('music', function() WindowMain.v = not WindowMain.v imgui.Process = WindowMain.v end)
    notify.addNotify('MusicPlay','Скрипт был успешно загружен!\nТекущая версия: '..thisScript().version,2,1,4)
    
    autoupdate('https://api.jsonbin.io/b/600470e74f42973a289e108d', '['..string.upper(thisScript().name)..']: ', 'https://api.jsonbin.io/b/600470e74f42973a289e108d')

    while true do wait(0)
        if isKeyDown(0x1B) and WindowMain.v == true then
            WindowMain.v = false
        elseif isKeyDown(0x1B) and WindowNewMusic.v == true then
            WindowNewMusic.v = false 
        end
    end
end

function imgui.OnDrawFrame()

    local X, Y = getScreenResolution()

    if not WindowMain.v and not WindowNewMusic.v then
        imgui.Process = false
    end

    if WindowMain.v then
		imgui.SetNextWindowSize(imgui.ImVec2(615, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(X / 2, Y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.Begin(fa.ICON_MUSIC .. u8' Музыкальное меню! ' .. fa.ICON_MUSIC, WindowMain, imgui.WindowFlags.NoResize)
                if NullPesen == 1 then
                    if imgui.Button(u8'Добавить музыку', imgui.ImVec2(190, 20)) then
                        WindowNewMusic.v = true
                    end
                end
                imgui.SameLine()
                imgui.CenterText(u8'Ваша музыка:')
                imgui.BeginChild('Osnova', imgui.ImVec2(599.5, 340), true)
                    if NullPesen == 0 then
                        
                        imgui.SetCursorPos(imgui.ImVec2(120, 135))
                        imgui.CenterText(u8'У Вас еще нет ни одной песни!')
                        imgui.SetCursorPos(imgui.ImVec2(218.5, 157))
                        if imgui.Button(fa.ICON_CLOUD_DOWNLOAD .. u8' Добавить песню!', imgui.ImVec2(145, 30)) then
                            WindowNewMusic.v = true
                        end

                    elseif NullPesen == 1 then
                        -- НУЛЕВАЯ СТРОКА
                        imgui.Columns(3)
                        imgui.Text(u8'Название песни:')
                        imgui.NextColumn()
                        imgui.Text(u8'URL-адрес:')
                        imgui.NextColumn()
                        imgui.Text(u8'Доступные действия:')
                        imgui.Separator()

                        -- ПЕРВАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 34))
                        imgui.Text(u8''..mainIni.Music.NamePesnya)
                        if imgui.IsItemHovered() then
                            imgui.BeginTooltip()
                            imgui.TextUnformatted(u8('Полное название: '..mainIni.Music.NamePesnya))
                            imgui.EndTooltip()
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(202, 34))
                        imgui.Text(u8''..mainIni.Music.URL)
                        if imgui.IsItemHovered() then
                            imgui.BeginTooltip()
                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music.URL))
                            imgui.EndTooltip()
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 33))
                            if imgui.Button(fa.ICON_PLAY .. '##1',imgui.ImVec2(43, 20)) then
                                notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music.NamePesnya),2,1,5)
                                    if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                        if mainIni.Music.URL ~= '' and string.lower(mainIni.Music.URL):find('http') then
                                            PlayPesnya = loadAudioStream(mainIni.Music.URL)
                                            setAudioStreamState(PlayPesnya, as_action.PLAY)
                                        end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(442, 33))
                            if imgui.Button(fa.ICON_STOP .. '##2',imgui.ImVec2(43, 20)) then
                                if PlayPesnya == nil then
                                    notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                                elseif PlayPesnya ~= nil then
                                    setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                        notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                                end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(490, 33))
                            if imgui.Button(fa.ICON_REFRESH .. '##3',imgui.ImVec2(41,20)) then
                                notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                            end
                        imgui.SetCursorPos(imgui.ImVec2(535, 33))
                            if imgui.Button(fa.ICON_TRASH .. '##4',imgui.ImVec2(42,20)) then
                                Pesn = Pesn - 1
                                    mainIni.Music.NamePesnya = ''
                                        mainIni.Music.URL = ''
                                            mainIni.Znachenia.Pesn = Pesn
                                                inicfg.save(mainIni, directIni)
                            end
                        imgui.Separator()

                        -- ВТОРАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 64))
                        if mainIni.Music1.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music1.NamePesnya)
                                if imgui.IsItemHovered() then
                                    imgui.BeginTooltip()
                                    imgui.TextUnformatted(u8('Полное название: '..mainIni.Music1.NamePesnya))
                                    imgui.EndTooltip()
                                end
                                    imgui.NextColumn()
                                        imgui.SetCursorPos(imgui.ImVec2(202, 64))
                                            imgui.Text(u8''..mainIni.Music1.URL)
                                                if imgui.IsItemHovered() then
                                                    imgui.BeginTooltip()
                                                    imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music1.URL))
                                                    imgui.EndTooltip()
                                                end
                        elseif mainIni.Music1.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 64))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                            imgui.SetCursorPos(imgui.ImVec2(395, 63))
                                if imgui.Button(fa.ICON_PLAY .. '##5',imgui.ImVec2(43, 20)) then
                                    notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music1.NamePesnya),2,1,5)
                                        if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                            if mainIni.Music1.URL ~= '' and string.lower(mainIni.Music1.URL):find('http') then
                                                PlayPesnya = loadAudioStream(mainIni.Music1.URL)
                                                setAudioStreamState(PlayPesnya, as_action.PLAY)
                                            end
                                end
                            imgui.SetCursorPos(imgui.ImVec2(442, 63))
                                if imgui.Button(fa.ICON_STOP .. '##6',imgui.ImVec2(43, 20)) then
                                    if PlayPesnya == nil then
                                        notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                                    elseif PlayPesnya ~= nil then
                                        setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                            notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                                    end
                                end
                            imgui.SetCursorPos(imgui.ImVec2(490, 63))
                                if imgui.Button(fa.ICON_REFRESH .. '##7',imgui.ImVec2(41,20)) then
                                    notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                                end
                            imgui.SetCursorPos(imgui.ImVec2(535, 63))
                                if imgui.Button(fa.ICON_TRASH .. '##8',imgui.ImVec2(42,20)) then
                                    mainIni.Music1.NamePesnya = ''
                                        mainIni.Music1.URL = ''
                                            Pesn = Pesn - 1
                                                mainIni.Znachenia.Pesn = Pesn
                                                    inicfg.save(mainIni, directIni)
                                end
                        imgui.Separator()

                        -- ТРЕТЬЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 94))
                        if mainIni.Music2.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music2.NamePesnya)
                                if imgui.IsItemHovered() then
                                    imgui.BeginTooltip()
                                    imgui.TextUnformatted(u8('Полное название: '..mainIni.Music2.NamePesnya))
                                    imgui.EndTooltip()
                                end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 94))
                                        imgui.Text(u8''..mainIni.Music2.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music2.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music2.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 94))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 93))
                            if imgui.Button(fa.ICON_PLAY .. '##9',imgui.ImVec2(43, 20)) then
                                notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music2.NamePesnya),2,1,5)
                                    if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                        if mainIni.Music2.URL ~= '' and string.lower(mainIni.Music2.URL):find('http') then
                                            PlayPesnya = loadAudioStream(mainIni.Music2.URL)
                                            setAudioStreamState(PlayPesnya, as_action.PLAY)
                                        end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(442, 93))
                            if imgui.Button(fa.ICON_STOP .. '##10',imgui.ImVec2(43, 20)) then
                                if PlayPesnya == nil then
                                    notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                                elseif PlayPesnya ~= nil then
                                    setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                        notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                                end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(490, 93))
                            if imgui.Button(fa.ICON_REFRESH .. '##11',imgui.ImVec2(41,20)) then
                                notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                            end
                        imgui.SetCursorPos(imgui.ImVec2(535, 93))
                            if imgui.Button(fa.ICON_TRASH .. '##12',imgui.ImVec2(42,20)) then
                                mainIni.Music2.NamePesnya = ''
                                    mainIni.Music2.URL = ''
                                        Pesn = Pesn - 1
                                            mainIni.Znachenia.Pesn = Pesn
                                                inicfg.save(mainIni, directIni)
                            end
                        imgui.Separator()

                        -- ЧЕТВЕРТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 124))
                        if mainIni.Music3.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music3.NamePesnya)
                                if imgui.IsItemHovered() then
                                    imgui.BeginTooltip()
                                    imgui.TextUnformatted(u8('Полное название: '..mainIni.Music3.NamePesnya))
                                    imgui.EndTooltip()
                                end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 124))
                                        imgui.Text(u8''..mainIni.Music3.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music3.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music3.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 124))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 123))
                            if imgui.Button(fa.ICON_PLAY .. '##13',imgui.ImVec2(43, 20)) then
                                notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music3.NamePesnya),2,1,5)
                                    if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                        if mainIni.Music3.URL ~= '' and string.lower(mainIni.Music3.URL):find('http') then
                                            PlayPesnya = loadAudioStream(mainIni.Music3.URL)
                                            setAudioStreamState(PlayPesnya, as_action.PLAY)
                                        end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(442, 123))
                            if imgui.Button(fa.ICON_STOP .. '##14',imgui.ImVec2(43, 20)) then
                                if PlayPesnya == nil then
                                    notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                                elseif PlayPesnya ~= nil then
                                    setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                        notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                                end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(490, 123))
                            if imgui.Button(fa.ICON_REFRESH .. '##15',imgui.ImVec2(41,20)) then
                                notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                            end
                        imgui.SetCursorPos(imgui.ImVec2(535, 123))
                            if imgui.Button(fa.ICON_TRASH .. '##16',imgui.ImVec2(42,20)) then
                                mainIni.Music3.NamePesnya = ''
                                    mainIni.Music3.URL = ''
                                        Pesn = Pesn - 1
                                            mainIni.Znachenia.Pesn = Pesn
                                                inicfg.save(mainIni, directIni)
                            end
                        imgui.Separator()

                        -- ПЯТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 154))
                        if mainIni.Music4.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music4.NamePesnya)
                                if imgui.IsItemHovered() then
                                    imgui.BeginTooltip()
                                    imgui.TextUnformatted(u8('Полное название: '..mainIni.Music4.NamePesnya))
                                    imgui.EndTooltip()
                                end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 154))
                                        imgui.Text(u8''..mainIni.Music4.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music4.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music4.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 154))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 153))
                            if imgui.Button(fa.ICON_PLAY .. '##17',imgui.ImVec2(43, 20)) then
                                notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music4.NamePesnya),2,1,5)
                                    if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                        if mainIni.Music4.URL ~= '' and string.lower(mainIni.Music4.URL):find('http') then
                                            PlayPesnya = loadAudioStream(mainIni.Music4.URL)
                                            setAudioStreamState(PlayPesnya, as_action.PLAY)
                                        end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(442, 153))
                            if imgui.Button(fa.ICON_STOP .. '##18',imgui.ImVec2(43, 20)) then
                                if PlayPesnya == nil then
                                    notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                                elseif PlayPesnya ~= nil then
                                    setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                        notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                                end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(490, 153))
                            if imgui.Button(fa.ICON_REFRESH .. '##19',imgui.ImVec2(41,20)) then
                                notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                            end
                        imgui.SetCursorPos(imgui.ImVec2(535, 153))
                            if imgui.Button(fa.ICON_TRASH .. '##20',imgui.ImVec2(42,20)) then
                                mainIni.Music4.NamePesnya = ''
                                    mainIni.Music4.URL = ''
                                        Pesn = Pesn - 1
                                            mainIni.Znachenia.Pesn = Pesn
                                                inicfg.save(mainIni, directIni)
                            end
                        imgui.Separator()

                        -- ШЕСТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 184))
                        if mainIni.Music5.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music5.NamePesnya)
                                if imgui.IsItemHovered() then
                                    imgui.BeginTooltip()
                                    imgui.TextUnformatted(u8('Полное название: '..mainIni.Music5.NamePesnya))
                                    imgui.EndTooltip()
                                end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 184))
                                        imgui.Text(u8''..mainIni.Music5.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music5.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music5.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 184))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 183))
                            if imgui.Button(fa.ICON_PLAY .. '##21',imgui.ImVec2(43, 20)) then
                                notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music5.NamePesnya),2,1,5)
                                    if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                        if mainIni.Music5.URL ~= '' and string.lower(mainIni.Music5.URL):find('http') then
                                            PlayPesnya = loadAudioStream(mainIni.Music5.URL)
                                            setAudioStreamState(PlayPesnya, as_action.PLAY)
                                        end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(442, 183))
                            if imgui.Button(fa.ICON_STOP .. '##22',imgui.ImVec2(43, 20)) then
                                if PlayPesnya == nil then
                                    notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                                elseif PlayPesnya ~= nil then
                                    setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                        notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                                end
                            end
                        imgui.SetCursorPos(imgui.ImVec2(490, 183))
                            if imgui.Button(fa.ICON_REFRESH .. '##23',imgui.ImVec2(41,20)) then
                                notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                            end
                        imgui.SetCursorPos(imgui.ImVec2(535, 183))
                            if imgui.Button(fa.ICON_TRASH .. '##24',imgui.ImVec2(42,20)) then
                                mainIni.Music5.NamePesnya = ''
                                    mainIni.Music5.URL = ''
                                        Pesn = Pesn - 1
                                            mainIni.Znachenia.Pesn = Pesn
                                                inicfg.save(mainIni, directIni)
                            end
                        imgui.Separator()

                        -- СЕДЬМАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 214))
                        if mainIni.Music6.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music6.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music6.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 214))
                                        imgui.Text(u8''..mainIni.Music6.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music6.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music6.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 214))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 213))
                        if imgui.Button(fa.ICON_PLAY .. '##25',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music6.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music6.URL ~= '' and string.lower(mainIni.Music6.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music6.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 213))
                        if imgui.Button(fa.ICON_STOP .. '##26',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 213))
                        if imgui.Button(fa.ICON_REFRESH .. '##27',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 213))
                        if imgui.Button(fa.ICON_TRASH .. '##28',imgui.ImVec2(42,20)) then
                            mainIni.Music6.NamePesnya = ''
                                mainIni.Music6.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ВОСЬМАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 244))
                        if mainIni.Music7.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music7.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music7.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 244))
                                        imgui.Text(u8''..mainIni.Music7.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music7.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music7.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 244))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 243))
                        if imgui.Button(fa.ICON_PLAY .. '##29',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music7.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music7.URL ~= '' and string.lower(mainIni.Music7.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music7.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 243))
                        if imgui.Button(fa.ICON_STOP .. '##30',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 243))
                        if imgui.Button(fa.ICON_REFRESH .. '##31',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 243))
                        if imgui.Button(fa.ICON_TRASH .. '##32',imgui.ImVec2(42,20)) then
                            mainIni.Music7.NamePesnya = ''
                                mainIni.Music7.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДЕВЯТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 274))
                        if mainIni.Music8.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music8.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music8.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 274))
                                        imgui.Text(u8''..mainIni.Music8.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music8.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music8.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 274))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 273))
                        if imgui.Button(fa.ICON_PLAY .. '##33',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music8.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music8.URL ~= '' and string.lower(mainIni.Music8.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 273))
                        if imgui.Button(fa.ICON_STOP .. '##34',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 273))
                        if imgui.Button(fa.ICON_REFRESH .. '##35',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 273))
                        if imgui.Button(fa.ICON_TRASH .. '##36',imgui.ImVec2(42,20)) then
                            mainIni.Music8.NamePesnya = ''
                                mainIni.Music8.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДЕСЯТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 304))
                        if mainIni.Music9.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music9.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music9.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 304))
                                        imgui.Text(u8''..mainIni.Music9.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music9.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music9.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 304))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 303))
                        if imgui.Button(fa.ICON_PLAY .. '##37',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music9.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music9.URL ~= '' and string.lower(mainIni.Music9.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music9.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 303))
                        if imgui.Button(fa.ICON_STOP .. '##38',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 303))
                        if imgui.Button(fa.ICON_REFRESH .. '##39',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 303))
                        if imgui.Button(fa.ICON_TRASH .. '##40',imgui.ImVec2(42,20)) then
                            mainIni.Music9.NamePesnya = ''
                                mainIni.Music9.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ОДИННАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 334))
                        if mainIni.Music10.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music10.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music10.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 334))
                                        imgui.Text(u8''..mainIni.Music10.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music10.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music10.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 334))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 333))
                        if imgui.Button(fa.ICON_PLAY .. '##41',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music10.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music10.URL ~= '' and string.lower(mainIni.Music10.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music10.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 333))
                        if imgui.Button(fa.ICON_STOP .. '##42',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 333))
                        if imgui.Button(fa.ICON_REFRESH .. '##43',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 333))
                        if imgui.Button(fa.ICON_TRASH .. '##44',imgui.ImVec2(42,20)) then
                            mainIni.Music10.NamePesnya = ''
                                mainIni.Music10.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДВЕНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 364))
                        if mainIni.Music11.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music11.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music11.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 364))
                                        imgui.Text(u8''..mainIni.Music11.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music11.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music11.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 364))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 363))
                        if imgui.Button(fa.ICON_PLAY .. '##45',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music11.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music11.URL ~= '' and string.lower(mainIni.Music11.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music11.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 363))
                        if imgui.Button(fa.ICON_STOP .. '##46',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 363))
                        if imgui.Button(fa.ICON_REFRESH .. '##47',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 363))
                        if imgui.Button(fa.ICON_TRASH .. '##48',imgui.ImVec2(42,20)) then
                            mainIni.Music11.NamePesnya = ''
                                mainIni.Music11.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ТРИНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 394))
                        if mainIni.Music12.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music12.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music12.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 394))
                                        imgui.Text(u8''..mainIni.Music12.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music12.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music12.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 394))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 393))
                        if imgui.Button(fa.ICON_PLAY .. '##49',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music12.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music12.URL ~= '' and string.lower(mainIni.Music12.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music12.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 393))
                        if imgui.Button(fa.ICON_STOP .. '##50',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 393))
                        if imgui.Button(fa.ICON_REFRESH .. '##51',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 393))
                        if imgui.Button(fa.ICON_TRASH .. '##52',imgui.ImVec2(42,20)) then
                            mainIni.Music12.NamePesnya = ''
                                mainIni.Music12.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ЧЕТЫРНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 424))
                        if mainIni.Music13.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music13.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music13.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 424))
                                        imgui.Text(u8''..mainIni.Music13.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music13.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music13.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 424))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 423))
                        if imgui.Button(fa.ICON_PLAY .. '##53',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music13.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music13.URL ~= '' and string.lower(mainIni.Music13.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music13.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 423))
                        if imgui.Button(fa.ICON_STOP .. '##54',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 423))
                        if imgui.Button(fa.ICON_REFRESH .. '##55',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 423))
                        if imgui.Button(fa.ICON_TRASH .. '##56',imgui.ImVec2(42,20)) then
                            mainIni.Music13.NamePesnya = ''
                                mainIni.Music13.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ПЯТНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 454))
                        if mainIni.Music14.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music14.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music14.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 454))
                                        imgui.Text(u8''..mainIni.Music14.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music14.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music14.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 454))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 453))
                        if imgui.Button(fa.ICON_PLAY .. '##57',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music14.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music14.URL ~= '' and string.lower(mainIni.Music14.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music14.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 453))
                        if imgui.Button(fa.ICON_STOP .. '##58',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 453))
                        if imgui.Button(fa.ICON_REFRESH .. '##59',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 453))
                        if imgui.Button(fa.ICON_TRASH .. '##60',imgui.ImVec2(42,20)) then
                            mainIni.Music14.NamePesnya = ''
                                mainIni.Music14.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ШЕСТНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 484))
                        if mainIni.Music15.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music15.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music15.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 484))
                                        imgui.Text(u8''..mainIni.Music15.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music15.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music15.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 484))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 483))
                        if imgui.Button(fa.ICON_PLAY .. '##61',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music15.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music15.URL ~= '' and string.lower(mainIni.Music15.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music15.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 483))
                        if imgui.Button(fa.ICON_STOP .. '##62',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 483))
                        if imgui.Button(fa.ICON_REFRESH .. '##63',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 483))
                        if imgui.Button(fa.ICON_TRASH .. '##64',imgui.ImVec2(42,20)) then
                            mainIni.Music15.NamePesnya = ''
                                mainIni.Music15.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- СЕМНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 514))
                        if mainIni.Music16.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music16.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music16.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 514))
                                        imgui.Text(u8''..mainIni.Music16.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music16.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music16.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 514))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 513))
                        if imgui.Button(fa.ICON_PLAY .. '##65',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music16.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music16.URL ~= '' and string.lower(mainIni.Music16.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music16.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 513))
                        if imgui.Button(fa.ICON_STOP .. '##66',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 513))
                        if imgui.Button(fa.ICON_REFRESH .. '##67',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 513))
                        if imgui.Button(fa.ICON_TRASH .. '##68',imgui.ImVec2(42,20)) then
                            mainIni.Music16.NamePesnya = ''
                                mainIni.Music16.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ВОСЕМНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 544))
                        if mainIni.Music17.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music17.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music17.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 544))
                                        imgui.Text(u8''..mainIni.Music17.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music17.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music17.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 544))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 543))
                        if imgui.Button(fa.ICON_PLAY .. '##69',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music17.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music17.URL ~= '' and string.lower(mainIni.Music17.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music17.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 543))
                        if imgui.Button(fa.ICON_STOP .. '##70',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 543))
                        if imgui.Button(fa.ICON_REFRESH .. '##71',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 543))
                        if imgui.Button(fa.ICON_TRASH .. '##72',imgui.ImVec2(42,20)) then
                            mainIni.Music17.NamePesnya = ''
                                mainIni.Music17.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДЕВЯТНАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 574))
                        if mainIni.Music18.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music18.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music18.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 574))
                                        imgui.Text(u8''..mainIni.Music18.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music18.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music18.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 574))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 573))
                        if imgui.Button(fa.ICON_PLAY .. '##73',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music18.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music18.URL ~= '' and string.lower(mainIni.Music18.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music18.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 573))
                        if imgui.Button(fa.ICON_STOP .. '##74',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 573))
                        if imgui.Button(fa.ICON_REFRESH .. '##75',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 573))
                        if imgui.Button(fa.ICON_TRASH .. '##76',imgui.ImVec2(42,20)) then
                            mainIni.Music18.NamePesnya = ''
                                mainIni.Music18.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДВАДЦАТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 604))
                        if mainIni.Music19.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music19.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music19.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 604))
                                        imgui.Text(u8''..mainIni.Music19.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music19.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music19.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 604))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 603))
                        if imgui.Button(fa.ICON_PLAY .. '##77',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music19.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music19.URL ~= '' and string.lower(mainIni.Music19.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music19.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 603))
                        if imgui.Button(fa.ICON_STOP .. '##78',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 603))
                        if imgui.Button(fa.ICON_REFRESH .. '##79',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 603))
                        if imgui.Button(fa.ICON_TRASH .. '##80',imgui.ImVec2(42,20)) then
                            mainIni.Music19.NamePesnya = ''
                                mainIni.Music19.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДВАДЦАТЬ ПЕРВАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 634))
                        if mainIni.Music20.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music20.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music20.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 634))
                                        imgui.Text(u8''..mainIni.Music20.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music20.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music20.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 634))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 633))
                        if imgui.Button(fa.ICON_PLAY .. '##81',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music20.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music20.URL ~= '' and string.lower(mainIni.Music20.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music20.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 633))
                        if imgui.Button(fa.ICON_STOP .. '##82',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 633))
                        if imgui.Button(fa.ICON_REFRESH .. '##83',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 633))
                        if imgui.Button(fa.ICON_TRASH .. '##84',imgui.ImVec2(42,20)) then
                            mainIni.Music20.NamePesnya = ''
                                mainIni.Music20.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДВАДЦАТЬ ВТОРАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 664))
                        if mainIni.Music21.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music21.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music21.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 664))
                                        imgui.Text(u8''..mainIni.Music21.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music21.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music21.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 664))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 663))
                        if imgui.Button(fa.ICON_PLAY .. '##85',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music21.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music21.URL ~= '' and string.lower(mainIni.Music21.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music21.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 663))
                        if imgui.Button(fa.ICON_STOP .. '##86',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 663))
                        if imgui.Button(fa.ICON_REFRESH .. '##87',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 663))
                        if imgui.Button(fa.ICON_TRASH .. '##88',imgui.ImVec2(42,20)) then
                            mainIni.Music21.NamePesnya = ''
                                mainIni.Music21.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДВАДЦАТЬ ТРЕТЬЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 694))
                        if mainIni.Music22.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music22.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music22.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 694))
                                        imgui.Text(u8''..mainIni.Music22.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music22.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music22.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 694))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 693))
                        if imgui.Button(fa.ICON_PLAY .. '##89',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music22.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music22.URL ~= '' and string.lower(mainIni.Music22.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music22.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 693))
                        if imgui.Button(fa.ICON_STOP .. '##90',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 693))
                        if imgui.Button(fa.ICON_REFRESH .. '##91',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 693))
                        if imgui.Button(fa.ICON_TRASH .. '##92',imgui.ImVec2(42,20)) then
                            mainIni.Music22.NamePesnya = ''
                                mainIni.Music22.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДВАДЦАТЬ ЧЕТВЕРТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 724))
                        if mainIni.Music23.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music23.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music23.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 724))
                                        imgui.Text(u8''..mainIni.Music23.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music23.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music23.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 724))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 723))
                        if imgui.Button(fa.ICON_PLAY .. '##93',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music23.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music23.URL ~= '' and string.lower(mainIni.Music23.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music23.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 723))
                        if imgui.Button(fa.ICON_STOP .. '##94',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 723))
                        if imgui.Button(fa.ICON_REFRESH .. '##95',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 723))
                        if imgui.Button(fa.ICON_TRASH .. '##96',imgui.ImVec2(42,20)) then
                            mainIni.Music23.NamePesnya = ''
                                mainIni.Music23.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()

                        -- ДВАДЦАТЬ ПЯТАЯ СТРОКА
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(8, 754))
                        if mainIni.Music24.NamePesnya ~= '' then
                            imgui.Text(u8''..mainIni.Music24.NamePesnya)
                            if imgui.IsItemHovered() then
                                imgui.BeginTooltip()
                                imgui.TextUnformatted(u8('Полное название: '..mainIni.Music24.NamePesnya))
                                imgui.EndTooltip()
                            end
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 754))
                                        imgui.Text(u8''..mainIni.Music24.URL)
                                        if imgui.IsItemHovered() then
                                            imgui.BeginTooltip()
                                            imgui.TextUnformatted(u8('Полная ссылка: '..mainIni.Music24.URL))
                                            imgui.EndTooltip()
                                        end
                        elseif mainIni.Music24.NamePesnya == '' then
                            imgui.Text('')
                                imgui.NextColumn()
                                    imgui.SetCursorPos(imgui.ImVec2(202, 754))
                                        imgui.Text('')
                        end
                        imgui.NextColumn()
                        imgui.SetCursorPos(imgui.ImVec2(395, 753))
                        if imgui.Button(fa.ICON_PLAY .. '##97',imgui.ImVec2(43, 20)) then
                            notify.addNotify('MusicPlay','Сейчас играет:\n'..u8:decode(mainIni.Music24.NamePesnya),2,1,5)
                                if PlayPesnya ~= nil then setAudioStreamState(PlayPesnya, as_action.STOP) end
                                    if mainIni.Music24.URL ~= '' and string.lower(mainIni.Music24.URL):find('http') then
                                        PlayPesnya = loadAudioStream(mainIni.Music24.URL)
                                        setAudioStreamState(PlayPesnya, as_action.PLAY)
                                    end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(442, 753))
                        if imgui.Button(fa.ICON_STOP .. '##98',imgui.ImVec2(43, 20)) then
                            if PlayPesnya == nil then
                                notify.addNotify('MusicPlay','Что Вы собрались останавливать?',2,1,3)
                            elseif PlayPesnya ~= nil then
                                setAudioStreamState(PlayPesnya, as_action.PAUSE)
                                    notify.addNotify('MusicPlay','Песня была приостановлена',2,1,3)
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(490, 753))
                        if imgui.Button(fa.ICON_REFRESH .. '##99',imgui.ImVec2(41,20)) then
                            notify.addNotify('MusicPlay','Не реализовано!\nБудет в следующих версиях.',2,1,4)
                        end
                        imgui.SetCursorPos(imgui.ImVec2(535, 753))
                        if imgui.Button(fa.ICON_TRASH .. '##100',imgui.ImVec2(42,20)) then
                            mainIni.Music24.NamePesnya = '' 
                                mainIni.Music24.URL = ''
                                    Pesn = Pesn - 1
                                        mainIni.Znachenia.Pesn = Pesn
                                            inicfg.save(mainIni, directIni)
                        end
                        imgui.Separator()
                    end
                imgui.EndChild()
            imgui.End()
    end

    if WindowNewMusic.v then
        imgui.SetNextWindowSize(imgui.ImVec2(450, 178), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(X / 2, Y / 1.8), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.Begin(u8'Добавляем музыку!', WindowNewMusic, imgui.WindowFlags.NoResize)
                imgui.Text(u8'Введите название песни:')
                imgui.InputText('##1', NamePesnya)
                imgui.NewLine()
                imgui.Text(u8'Введите URL-адрес на Вашу песню:')
                imgui.InputText('##2', URL)
                if TextError == 0 then
                    imgui.NewLine()
                elseif TextError == 1 then
                    imgui.CenterTextColoredRGB('{FF0000}Укажите название песни и URL-адрес!')
                elseif TextError == 2 then
                    imgui.CenterTextColoredRGB('{FF0000}Укажите название песни!')
                elseif TextError == 3 then
                    imgui.CenterTextColoredRGB('{FF0000}Укажите URL-адрес!')
                elseif TextError == 4 then
                    imgui.CenterTextColoredRGB('{FF0000}Сохранено максимальное количество песен!')
                end
                    if imgui.Button(fa.ICON_FLOPPY_O .. u8' Добавить новую песню!', imgui.ImVec2(-1, 20)) then
                        if URL.v == '' and NamePesnya.v == '' then
                            TextError = 1
                        elseif NamePesnya.v == '' then
                            TextError = 2
                        elseif URL.v == '' then
                            TextError = 3
                        elseif Pesn == 25 then
                            TextError = 4
                        elseif NamePesnya.v ~= '' and URL.v ~= '' then
                            WindowNewMusic.v = false
                                if mainIni.Music.URL == '' then
                                        mainIni.Music.URL = URL.v
                                            mainIni.Music.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music.URL ~= '' and mainIni.Music1.URL == '' then
                                        mainIni.Music1.URL = URL.v
                                            mainIni.Music1.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music1.URL ~= '' and mainIni.Music2.URL == '' then 
                                        mainIni.Music2.URL = URL.v
                                            mainIni.Music2.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music2.URL ~= '' and mainIni.Music3.URL == '' then
                                        mainIni.Music3.URL = URL.v
                                            mainIni.Music3.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music3.URL ~= '' and mainIni.Music4.URL == '' then
                                        mainIni.Music4.URL = URL.v
                                            mainIni.Music4.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music4.URL ~= '' and mainIni.Music5.URL == '' then
                                        mainIni.Music5.URL = URL.v
                                            mainIni.Music5.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music5.URL ~= '' and mainIni.Music6.URL == '' then
                                        mainIni.Music6.URL = URL.v
                                            mainIni.Music6.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music6.URL ~= '' and mainIni.Music7.URL == '' then
                                        mainIni.Music7.URL = URL.v
                                            mainIni.Music7.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music7.URL ~= '' and mainIni.Music8.URL == '' then
                                        mainIni.Music8.URL = URL.v
                                            mainIni.Music8.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music8.URL ~= '' and mainIni.Music9.URL == '' then
                                        mainIni.Music9.URL = URL.v
                                            mainIni.Music9.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music9.URL ~= '' and mainIni.Music10.URL == '' then
                                        mainIni.Music10.URL = URL.v
                                            mainIni.Music10.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music10.URL ~= '' and mainIni.Music11.URL == '' then
                                        mainIni.Music11.URL = URL.v
                                            mainIni.Music11.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music11.URL ~= '' and mainIni.Music12.URL == '' then
                                        mainIni.Music12.URL = URL.v
                                            mainIni.Music12.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music12.URL ~= '' and mainIni.Music13.URL == '' then
                                        mainIni.Music13.URL = URL.v
                                            mainIni.Music13.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music13.URL ~= '' and mainIni.Music14.URL == '' then
                                        mainIni.Music14.URL = URL.v
                                            mainIni.Music14.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music14.URL ~= '' and mainIni.Music15.URL == '' then
                                        mainIni.Music15.URL = URL.v
                                            mainIni.Music15.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music15.URL ~= '' and mainIni.Music16.URL == '' then
                                        mainIni.Music16.URL = URL.v
                                            mainIni.Music16.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music16.URL ~= '' and mainIni.Music17.URL == '' then
                                        mainIni.Music17.URL = URL.v
                                            mainIni.Music17.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music17.URL ~= '' and mainIni.Music18.URL == '' then
                                        mainIni.Music18.URL = URL.v
                                            mainIni.Music18.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music18.URL ~= '' and mainIni.Music19.URL == '' then
                                        mainIni.Music19.URL = URL.v
                                            mainIni.Music19.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music19.URL ~= '' and mainIni.Music20.URL == '' then
                                        mainIni.Music20.URL = URL.v
                                            mainIni.Music20.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music20.URL ~= '' and mainIni.Music21.URL == '' then
                                        mainIni.Music21.URL = URL.v
                                            mainIni.Music21.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music21.URL ~= '' and mainIni.Music22.URL == '' then
                                        mainIni.Music22.URL = URL.v
                                            mainIni.Music22.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music22.URL ~= '' and mainIni.Music23.URL == '' then
                                        mainIni.Music23.URL = URL.v
                                            mainIni.Music23.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music23.URL ~= '' and mainIni.Music24.URL == '' then
                                        mainIni.Music24.URL = URL.v
                                            mainIni.Music24.NamePesnya = NamePesnya.v
                                    elseif mainIni.Music24.URL ~= '' and mainIni.Music25.URL == '' then
                                        mainIni.Music25.URL = URL.v
                                            mainIni.Music25.NamePesnya = NamePesnya.v
                                end
                                    NullPesen = 1
                                        Pesn = Pesn + 1
                                            mainIni.Znachenia.NullPesen = NullPesen
                                                mainIni.Znachenia.Pesn = Pesn
                                                    inicfg.save(mainIni, directIni)
                                                        notify.addNotify('Сохранена новая песня!','Название песни: '..u8:decode(NamePesnya.v)..'\nСсылка на песню: '..u8:decode(URL.v),2,1,5)
                                                            URL.v = ''
                                                                NamePesnya.v = ''
                                                                    TextError = 0
                        end
                    end
            imgui.End()
    end
end

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function imgui.CenterTextColoredRGB(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end

-- Author: http://qrlk.me/samp

function autoupdate(json_url, prefix, url)
    local dlstatus = require('moonloader').download_status
    local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
    if doesFileExist(json) then os.remove(json) end
    downloadUrlToFile(json_url, json,
      function(id, status, p1, p2)
        if status == dlstatus.STATUSEX_ENDDOWNLOAD then
          if doesFileExist(json) then
            local f = io.open(json, 'r')
            if f then
              local info = decodeJson(f:read('*a'))
              updatelink = info.updateurl
              updateversion = info.latest
              f:close()
              os.remove(json)
              if updateversion ~= thisScript().version then
                lua_thread.create(function(prefix)
                  local dlstatus = require('moonloader').download_status
                  local color = -1
                  sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('Загружено %d из %d.', p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        print('Загрузка обновления завершена.')
                        sampAddChatMessage((prefix..'Обновление завершено!'), color)
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                          update = false
                        end
                      end
                    end
                  )
                  end, prefix
                )
              else
                update = false
                print('v'..thisScript().version..': Обновление не требуется.')
              end
            end
          else
            print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
  end
