QBCore.Commands.Add('addDonateCredit', 'Add Donate Credit (Admin Only)', { { name = 'PlayerID', help = 'ID of player' }, { name = 'Credit Count', help = '1000' }}, false, function(source, args)
    if args[1] and args[2] then
        addCredit(args[1], args[2])
    end
end, 'admin')

QBCore.Commands.Add('removeDonateCredit', 'Add Donate Credit (Admin Only)', { { name = 'PlayerID', help = 'ID of player' }, { name = 'Credit Count', help = '1000' }}, false, function(source, args)
    if args[1] and args[2] then
        removeCredit(args[1], args[2])
    end
end, 'admin')
