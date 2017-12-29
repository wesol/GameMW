# -*- coding: utf-8  -*-

import pymysql
import  Password.password
from random import randint
from random import choice

class GameMain(object):         
          
          def __init__(self):
                    #connecting with database
                    password = Password.password.password
                    self.conn = pymysql.connect('localhost','root',password, 'gameMW')
                    self.cursor = self.conn.cursor()
                    input(' Witajcie w grze. Aby przejść do MENU wciśnij "Enter"')
                    self.menu()
                    
          def menu(self):
                    while True:
                              action = (input('\n' + (10*'=' + 'MENU' + 10*'=').center(40) + '\n'
                                        + '"N" - Nowa gra'.center(50) + '\n'
                                        + '"R" - Rejestracja nowego gracza'.center(50) + '\n'
                                        + '"W" - Wyświetlenie listy kart'.center(50) + '\n'
                                        + '"V" - Wyświetlenie rankingu'.center(50) + '\n'
                                        + '"Q" - Wyjście z gry'.center(50)
                                        + '\n'+(26*'=').center(41)+'\n'*2).upper())
                              if action in ('N', 'R', 'W', 'V',  'Q', 'A12'):
                                        break   
                              else: 
                                        print('nic nie wybrano, wybierz ponownie')              
                    if action == 'N':
                              self.new_game()
                    elif action == 'R':
                              self.registration()
                    elif action == 'W':
                              self.cards()
                    elif action == 'V':
                              self.ranking()
                    elif action == 'Q':
                              self.quit()
                    elif action == 'A12':
                              self.adm_panel()                    
                    
          def new_game(self):
                    self.login(1)
                    self.login(2)
                    self.game_mechanic()
                    self.back()
                    
          def login (self, player_number):
                    print('Logowanie GRACZA NUMER '+ str(player_number))
                    print('w budowie, przekierownie do losowania kart')
                    self.draw_card()
                    
                    while True:
                              action = (input('\n'+(4*'='+'MENU LOGOWANIA'+4*'=').center(40)+'\n'
                                              +('GRACZ NUMER '+ str(self.player_number)).center(50)+'\n'
                                              +'"G" - GRAJ JAKO GOŚĆ'.center(50)+'\n'
                                              +'"L" - ZALOGUJ NORMALNIE'.center(50)+'\n').upper())
                              if action in ('G', 'L'):
                                        break   
                              else: 
                                        print('nic nie wybrano, wybierz ponownie')          
                                        
                    if action == 'G':
                              print('In building') 
                    elif action == 'L':
                              i=0
                              while i<3:
                                        login = (input('Wprowadź login: ').replace(' ','')).lower()
                                        if login == '':
                                                  print('Nic nie wprowadzono')
                                        elif  self.cursor.execute("select login from players where login ='" + str(login)+"'") == 0:
                                                  print('Nie ma takiego użytkownika w bazie')
                                                  i +=1
                                        else:
                                                  break
                              if i == 3:
                                        print('Jeśli nie pamiętasz danych logowania, skontaktuj się z administratorem.\nTymczasem, możesz zagrać jako gość.')
                              while True:
                                        player_pass = (input('Wprowadź hasło: ').replace(' ','')).lower()
                                        if player_pass == '':
                                                  print('Nic nie wprowadzono')
                                        elif  player_pass == self.cursor.execute("select password from players where login ='" + str(login)+"'"):
                                                  print('Błędne hasło')
                                        else:
                                                  break
                    
          def registration(self):
                    
                    while True:
                              action = input('Wprowadzenie danych nowego użytkownika.\nPo rejestracji będziesz mógł pracować nad poprawieniem swojego rankingu\nJeśli nie chcesz się rejestrować, wprowadź "M" aby wyjść do MENU').upper()
                              if action == 'M':
                                        self.menu()
                              while True:
                                        login = (input('Wprowadź login: ').replace(' ','')).lower()
                                        if login == '':
                                                  print('Nic nie wprowadzono')
                                        elif  self.cursor.execute("select login from players where login ='" + str(login)+"'") > 0:
                                                  print('Taki login jest już zajęty')
                                        else:
                                                  break
                              while True:
                                        email = (input('Wprowadź email: ').replace(' ','')).lower()
                                        if email == '':
                                                  print('Nic nie wprowadzono')
                                        
                                        elif  email.find('@') == -1 or email.find('.') == -1 or len(email)<5:
                                                  print('Wprowadzono niepoprawny adres email')
                                        elif self.cursor.execute("select email from players where email ='" + str(email)+"'") > 0:
                                                  print('Mamy już ten email w bazie')
                                        else:
                                                  break
                              while True:
                                        passw1 = (input('Wprowadź hasło (hasło nie może zawierać spacji, jeśli się pojawią program automatycznie je usunie): ').replace(' ',''))
                                        if passw1 == '':
                                                  print('Nic nie wprowadzono')
                                        else:
                                                  passw2 = (input('Potwierdź haslo: ').replace(' ',''))
                                                  if passw1 != passw2:
                                                            print('Podane hasła nie są takie same')
                                                  else:
                                                            break         
          
                              action = (input('Sprawdź czy wszystko się zgadza, jeśli nie, wpisz "NO" i zatwierdź\nLogin: '
                                              +str(login)+'\nEmail: '
                                              +str(email)+ '\nHasło: '
                                              +str(passw1)+'\n')).upper()
                              if action != 'NO':
                                        break
                    
                    self.cursor.execute(("insert into gameMW.players (login, password, email, first_log, last_log) values ('%s', '%s',' %s', now(), now())")
                                        % (login, email, passw1))
                    self.conn.commit()
                    print('Brawo, zostałeś poprawnie zarejstrowany!')
                    self.back()
                    
          def cards(self):
                    col_width = [8,20,30,20,20]
                    print('\nDostępne karty:\n'+'-' * (230) + '\n' 
                          + '|' + 'LP'.center(col_width[0]) + '|'
                          + ' IMIĘ'.center(col_width[1]) + '|'
                          + ' PRAWA RĘKA'.center(col_width[2]) + '|'
                          + ' LEWA RĘKA'.center(col_width[2]) + '|'
                          + 'ZBROJA'.center(col_width[3]+15) + '|'
                          + 'RASA'.center(col_width[3]) + '|'
                          + 'KLASA'.center(col_width[3]) + '|' 
                          + 'MIN. ATAK'.center(col_width[4]) + '|'
                          + 'MAKS. ATAK'.center(col_width[4]) + '|' 
                          + 'OBRONA'.center(col_width[4]) + '|\n' +'-'*(230))
                    self.cursor.execute("select * from summary_list order by ID")
                    for item in self.cursor.fetchall():
                              print('|' + str(item[0]).center(col_width[0])
                                    + '|' + str(item[1]).center(col_width[1])
                                    + '|' + str(item[2]).center(col_width[2])
                                    + '|' + str(item[3]).center(col_width[2])
                                    + '|' + str(item[4]).center(col_width[3]+15)
                                    + '|' + str(item[5]).center(col_width[3]) 
                                    + '|' + str(item[6]).center(col_width[3]) 
                                    + '|' + str(item[7]).center(col_width[4]) 
                                    + '|' + str(item[8]).center(col_width[4])
                                    + '|' + str(item[9]).center(col_width[4]) +'|')     
          
          def ranking(self):
                    col_width = [20,30,30,20,20]
                    print('\nOto aktualny ranking:\n'
                          + '-' * (sum(col_width)+15) + '\n'
                          + '|' + 'LOGIN'.center(col_width[0])
                          + '|' + 'DATA REJESTRACJI'.center(col_width[1]+11) 
                          + '|' + 'OSTATNIE LOGOWANIE'.center(col_width[2]+11)
                          + '|' + 'GRY'.center(col_width[3]-4)
                          + '|' +  'WYGRANE'.center(col_width[4]-4) + '|\n'
                          + '-'  * (sum(col_width)+15))
                    self.cursor.execute("select * from all_players where login != 'guest' and login != 'guest2'")
                    for item in self.cursor.fetchall():
                              print('|' + str(item[0]).center(col_width[0]) + '|'
                                    + str(item[1]).center(col_width[1]) + '|'
                                    + str(item[2]).center(col_width[2]) + '|'
                                    + str(item[3]).center(col_width[3]) + '|'
                                    + str(item[4]).center(col_width[4]) + '|')             
                    self.back()
                    
          def quit(self):
                    while True:
                              action = (input('Czy jesteś pewien, że chcesz wyjść z programu? (T/N)\n')).upper()
                              if action == 'T':
                                        print('Żegnaj, do następnego!')
                                        exit()
                              elif action == 'N':
                                        self.menu()
                              else:
                                        print('Coś, nie tak...')
                                        continue
          def adm_panel(self):
                    print ('Jesteś w panelu administracyjnym, możesz usuwać graczy z bazy danych lub ich banować')
                    #TODO: aministrations panel
                    self.back()
                    
          def draw_cards(self): 
                    draw = randint(1,2)
                    input(('Rozpoczyna GRACZ NUMER %s, aby kontynuować wciśnij ENTER') % (draw))
                    i = 0
                    while i < 2:
                              self.cards()
                              while True:
                                        lp = input('\nGRACZ NUMER: '+str(draw)+'\nWybierz kartę wspisując numer porzadkowy("Lp")\n: ')
                                        if lp == '':
                                                  print('NIC NIE WPROWADZONO')
                                        elif  (not lp.isdigit()) or (self.cursor.execute("select * from summary_list where ID =" + str(lp)) == 0):
                                                  print('\nBŁĘDNIE WYBRAŁEŚ, SPRÓBUJ JESZCZE RAZ!')
                                        else:
                                                  break
                              
                              self.cursor.execute(("insert into gameMW.player%s_hand select * from summary_list where ID=%s") % (draw, lp))
                              self.cursor.execute(("update gameMW.characters set choice = true where id_ch=%s") % (lp))
                              i+=1
                              if draw ==1:
                                        draw = 2
                              else:
                                        draw =1
                    input('\nFaza wyboru zakończona, wciśnij ENTER aby spojrzeć na dokonane wybory')   
                    self.show_hands()
          
          def show_hands(self): 
                    self.cursor.execute("select id_ph1, name, min_attack, max_attack, defence from player1_hand")
                    hand1 = self.cursor.fetchall()
                    self.cursor.execute("select id_ph2, name, min_attack, max_attack, defence from player2_hand")
                    hand2 = self.cursor.fetchall()
                    self.show_tables(1,hand1)
                    self.show_tables(2,hand2)
          
          def show_tables(self, player_number, lines_query):
                    separ_lenght = 110
                    print('\n'+'-' * separ_lenght+'\n|' + ('Ręka GRACZA NUMER ' + str(player_number)).center(separ_lenght+4) + '|\n' + '-' * separ_lenght)
                    print("|%-4s\t|%-30s\t|%-15s\t|%-15s\t|%-15s\t|" % ('LP', 'IMIĘ', 'MIN. ATAK', 'MAKS. ATAK','OBRONA'))
                    for item in lines_query:
                              print("|%-6s\t|%-30s\t|%-20s\t|%-20s\t|%-20s\t|"  % (str(item[0]), str(item[1]), str(item[2]), str(item[3]), str(item[4])))
          
          def game_mechanic(self):
                    #TODO: game mechanic
                    print('Mechanika rozgrywki w budowie')
                    
          def back(self):
                    input('\nENTER - powrót do MENU\n')
                    self.menu()
                    
GameMain()


 



