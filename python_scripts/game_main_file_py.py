# -*- coding: utf-8  -*-

import pymysql
import  Password.password

# #########################
# logowanie / rejestracja
# #########################

#while True:
          #o = input('wprowadź ocenę, jeśli chcesz zakończyć wciśnij enter: ')
          #if o != '':
                    #try:
                              #o = float(o)
                              #if o in listaO:
                                        #i += 1
                                        #wpr.append(o)
                              #else: 
                                        #z()
                    #except:
                              #z()
          #else:
                    #if i == 0:
                              #print('nie zostały wprowadzone żadne liczby')
                              #break
                    #else:
                              #print('wprowadzone oceny:',wpr,'średnia podanych ocen to:',round(sum(wpr)/i,2))
                              #break



class login:         
          ret = lambda:  input('ENTER - powrót do MENU/n')
          def __init__(self):
                    # łączenie się z bazą
                    password = Password.password.password
                    self.conn = pymysql.connect('localhost','root',password, 'gameMW')
                    self.cursor = self.conn.cursor()
                    input(' Witajcie w grze. Aby przejść do MENU wciśnij "Enter"')
                    self.menu()
          
          def menu(self):
                    while True:
                              action = (input('\n'+(10*'='+'MENU'+10*'=').center(40)+'\n'+'"N" - Nowa gra'.center(50)+'\n'+'"R" - Rejestracja nowego gracza'.center(50)+'\n'+'"W" - Wyświetlenie listy kart'.center(50)+'\n'+'"V" - Wyświetlenie rankingu'.center(50)+'\n'+'"Q" - Wyjście z gry'.center(50)+'\n'+(26*'=').center(41)+'\n'*2).upper())
                    
                              if action in ('N', 'R', 'W', 'V',  'Q'):
                                        if action == 'N':
                                                  self.newGame()
                                        elif action == 'R':
                                                  self.registration()
                                        elif action == 'W':
                                                  self.kards()
                                        elif action == 'V':
                                                  self.ranking()
                                        elif action == 'Q':
                                                  self.quit()
                                        elif action == 'A12':
                                                  self.admPanell()
                              else: 
                                        print('nic nie wybrano, wybierz ponownie')                  
                    
          def newGame(self):
                    print ('Aby rozpocząć grę, należy wprowadzić dane logowania')
                    ret()
          def registration(self):
                    print ('Dodanie nowego gracza')
                    self.ret()
          def kards(self):
                    print ('obejrzenie kart')
                    ret()
          # Wyświetlanie rankingu
          def ranking(self):
                    
                    formatt = [20,30,30,20,20] #szerokość kolumn
                    print('\nOto aktualny ranking:\n'+'-' * (sum(formatt)+15)+'\n' +
                          '|' + 'login'.center(formatt[0])+'|'+ ' first_log'.center(formatt[1]+11)+'|'+' last_log'.center(formatt[2]+11)+'|'+ 'plays'.center(formatt[3]-4)+'|'+  'wons'.center(formatt[4]-4) +'|\n'
                          +'-'*(sum(formatt)+15))
                    self.cursor.execute("select * from all_players where login != 'guest' and login != 'guest2'")
                    VIEW_players = self.cursor.fetchall()
                    for v in VIEW_players:
                              login = v[0]
                              first_log = v[1]                                        
                              last_log = v[2]                                        
                              plays = v[3]
                              wons = v[4]
                              print('|'+login.center(formatt[0])+'|'+ str(first_log).center(formatt[1])+'|'+ str(last_log).center(formatt[2])+'|'+ str(plays).center(formatt[3])+'|'+  str(wons).center(formatt[4])+'|')             
                    
                    ret()
          
          def quit(self):
                    action = (input('Napewno chcesz wyjść? Zatwierdź Y/N:\n')).upper()
                    while action:
                              if action == 'Y':
                                        print('Żegnaj, do następnego!')
                                        exit()
                              elif action == 'N':
                                        self.menu()
                                        
          def admPanel(self):
                    print ('Jesteś w panelu administracyjnym, możesz usuwać graczy z bazy danych lub ich banować')
                    
                    ret()
                    

login()
input('')





'''
class DBconnect:
          def __init__(self):
                    password = Password.extra.password
                    self.conn = pymysql.connect('localhost','root',password, 'ewidencja')
                    #ustawienie kursora na początku
                    self.cursor = self.conn.cursor()
                    i=0
                    while i < 3:
                              decision = self.login()
                              if decision:
                                        break
                              else:
                                        i+1
                              if i == 3:
                                        print('Jesteś słabym hasłołamaczem')
                    while decision:
                              choice = input('co chcesz zrobić  \n(S) - wypisz dane\n(I) - wprowadź dane \n(U) - zaktualizuj hasło \n(D) - wprowadź dane \n' ).upper()
                              if choice == 'S':
                                        self.select()
                              elif choice == 'I':
                                        self.insert()
                              elif choice == 'U':
                                        self.update()
                              elif choice == 'D':
                                        self.delete()                                        
                              else:
                                        print('bye')
                                        break
          def login(self):
                    mail = input('Podaj mail: ')
                    passw = input('Podaj password: ')
                    self.cursor.execute("select * from users where mail='%s' and passw='%s'" % (mail, passw))
                    RS = self.cursor.fetchall()
                    print(RS)
                    if(len(RS) == 0):
                              print('nie ok')
                              return False
                    else: 
                              print('ok')
                              return True
                              
          def select(self):
                    #wykonanie zapytania
                    self.cursor.execute('select  * from users')
                    #przypisanie zbioru wynikowego do RS
                    RS = self.cursor.fetchall()
                    for v in RS:
                              lp = v[0]
                              name = v[1]                                        
                              last = v[2]                                        
                              mail = v[3]                                        
                              passw = v[4]                                        
                              print('|%3i|%15s|%15s|%15s|%15s|' % (lp, name, last, mail,  "*"*5))
          def insert(self):
                    name = input ('podaj imie: ')
                    last = input ('podaj nazwisko: ')
                    mail = input ('podaj mail: ')
                    passw = input ('podaj haslo: ')
                    self.cursor.execute(("insert into users (name, last , mail, passw) values ('%s', '%s','%s','%s') ") % (name, last, mail, passw))
                    #--> to co musimy zakomitować
                    self.conn.commit()
          def update (self):
                    try:
                              lp = int(input('Podaj id dl aktórego chcesz zmienić hasło: '))
                              #break
                    except: 
                              print('Błędny id! Popraw się')
                    newPassword = int(input('Podaj nowe hasło: '))
                    self.password.execute = (("update users set passw = '%i' where id = '%i'") % (newPassword, lp))
                    self.conn.commit()
                    
          def delete(self):
                    try:
                              lp = int(input('Podaj id dla rekordu który chcesz usunąć: '))
                              #break
                    except: 
                              print('Błędny id! Popraw się')
                    self.password.execute = (("delete from users where id = '%i'") % (lp))
                    self.conn.commit()
                    
                    
                    
db1 = DBconnect()

'''