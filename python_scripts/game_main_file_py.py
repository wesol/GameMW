# -*- coding: utf-8  -*-

import pymysql
import  Password.password
from random import randint
from random import choice

class game_main:         
          
          def __init__(self):
                    # łączenie się z bazą
                    password = Password.password.password
                    self.conn = pymysql.connect('localhost','root',password, 'gameMW')
                    self.cursor = self.conn.cursor()
                    input(' Witajcie w grze. Aby przejść do MENU wciśnij "Enter"')
                    #self.menu()
                    # -------- Testowe
                    #self.registration()
                    #self.ranking()
                    #self.kards()
                    self.add_hand()
                    #self.show_hands()
                    #self.login(1)
          
          def menu(self):
                    while True:
                              action = (input('\n'+(10*'='+'MENU'+10*'=').center(40)+'\n'+'"N" - Nowa gra'.center(50)+'\n'+'"R" - Rejestracja nowego gracza'.center(50)+'\n'+'"W" - Wyświetlenie listy kart'.center(50)+'\n'+'"V" - Wyświetlenie rankingu'.center(50)+'\n'+'"Q" - Wyjście z gry'.center(50)+'\n'+(26*'=').center(41)+'\n'*2).upper())
                    
                              if action in ('N', 'R', 'W', 'V',  'Q', 'A12'):
                                        break   
                              else: 
                                        print('nic nie wybrano, wybierz ponownie')                  
                    
                    if action == 'N':
                              self.newGame()
                    elif action == 'R':
                              self.registration()
                    elif action == 'W':
                              self.kards_b()
                    elif action == 'V':
                              self.ranking()
                    elif action == 'Q':
                              self.quit()
                    elif action == 'A12':
                              self.admPanel()                    
                    
          def newGame(self):
                    print ('Aby rozpocząć grę, należy wprowadzić dane logowania')
                    self.back()
          def login (self, number):
                    self.number = number
                    print('Logowanie GRACZA NUMER '+ str(self.number))
                    print('w budowie, przekierownie do losowania kart')
                    add_hand()
                    
                    while True:
                              action = (input('\n'+(4*'='+'MENU LOGOWANIA'+4*'=').center(40)+'\n'+('GRACZ NUMER '+ str(self.number)).center(50)+'\n'+'"G" - GRAJ JAKO GOŚĆ'.center(50)+'\n'+'"L" - ZALOGUJ NORMALNIE'.center(50)+'\n').upper())
                    
                              if action in ('G', 'L'):
                                        break   
                              else: 
                                        print('nic nie wybrano, wybierz ponownie')                  
                    
                    if action == 'G':
                              GFDGDF
                    
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
                                        email = (input('Wprowadź email: ').replace(' ','')).lower() #usuwanie spacji
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
          
                              action = (input('Sprawdź czy wszystko się zgadza, jeśli nie, wpisz "NO" i zatwierdź\nLogin: '+str(login)+'\nEmail: '+str(email)+ '\nHasło: '+str(passw1)+'\n')).upper()
                              if action != 'NO':
                                        break
                    #zapisanie wprowadzonych danych do bazy:
                    self.cursor.execute(("insert into gameMW.players (login, password, email, first_log, last_log) values ('%s', '%s',' %s', now(), now())") % (login, email, passw1))
                    self.conn.commit()
                    print('Brawo, zostałeś poprawnie zarejstrowany!')
                    self.back()
          def kards(self):
                    formatt = [8,20,30,20,20] #szerokość kolumn
                    print('\nDostępne karty:\n'+'-' * (230)+'\n' +
                          '|' + 'Lp'.center(formatt[0])+'|'+' name'.center(formatt[1])+'|'+ ' right_hand'.center(formatt[2])+'|'+' left_hand'.center(formatt[2])+'|'+ 'armor'.center(formatt[3]+15)+'|'+  'race'.center(formatt[3]) +  '|'+'class'.center(formatt[3]) + '|' + 'min_attack'.center(formatt[4]) + '|' + 'max_attack'.center(formatt[4]) + '|' + 'defence'.center(formatt[4]) +'|\n'
                          +'-'*(230))
                    self.cursor.execute("select * from summary_list order by ID")
                    for v in self.cursor.fetchall():
                              print('|' + str(v[0]).center(formatt[0])+'|'+str(v[1]).center(formatt[1])+'|'+ str(v[2]).center(formatt[2])+'|'+str(v[3]).center(formatt[2])+'|'+ str(v[4]).center(formatt[3]+15)+'|'+  str(v[5]).center(formatt[3]) + '|'+str(v[6]).center(formatt[3]) + '|'+ str(v[7]).center(formatt[4]) + '|'+ str(v[8]).center(formatt[4]) + '|'+ str(v[9]).center(formatt[4]) +'|')     
          def kards_b(self):             
                    self.kards()
                    self.back()
          
          def ranking(self):
                    formatt = [20,30,30,20,20] #szerokość kolumn
                    print('\nOto aktualny ranking:\n'+'-' * (sum(formatt)+15)+'\n' +
                          '|' + 'login'.center(formatt[0])+'|'+ ' first_log'.center(formatt[1]+11)+'|'+' last_log'.center(formatt[2]+11)+'|'+ 'plays'.center(formatt[3]-4)+'|'+  'wons'.center(formatt[4]-4) +'|\n'
                          +'-'*(sum(formatt)+15))
                    self.cursor.execute("select * from all_players where login != 'guest' and login != 'guest2'")
                    for v in self.cursor.fetchall():
                              print('|'+str(v[0]).center(formatt[0])+'|'+ str(v[1]).center(formatt[1])+'|'+ str(v[2]).center(formatt[2])+'|'+ str(v[3]).center(formatt[3])+'|'+  str(v[4]).center(formatt[4])+'|')             
                    self.back()
          def quit(self):
                    while True:
                              action = (input('Czy jesteś pewien, że chcesz wyjść z programu? (Y/N)\n')).upper()
                              if action == 'Y':
                                        print('Żegnaj, do następnego!')
                                        exit()
                              elif action == 'N':
                                        self.menu()
                              else:
                                        print('Coś, nie tak...')
                                        continue
                                        
          def admPanel(self):
                    print ('Jesteś w panelu administracyjnym, możesz usuwać graczy z bazy danych lub ich banować')
                    
                    self.back()
          def add_hand(self): #loswoanie kart 
                    draw = randint(1,2)
                    input(('Rozpoczyna GRACZ NUMER %s, aby kontynuować wciśnij ENTER') % (draw))
                    i = 0
                    while i < 6:
                              self.kards()
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
          
          def show_hands(self): #do zoptymalizowania
                    self.cursor.execute("select id_ph1, name, min_attack, max_attack, defence from player1_hand")
                    self.h1 = self.cursor.fetchall()
                    self.cursor.execute("select id_ph2, name, min_attack, max_attack, defence from player2_hand")
                    self.h2 = self.cursor.fetchall()
                    self.write(1,self.h1)
                    self.write(2,self.h2)
          def write(self, number, wr): #wypisanie tabel z kartami graczy
                    r1_for = 105
                    formatt2 = [8,20,20] #szerokość kolumn          
                   
                    print('\n'+'-' * (r1_for)+'\n|' + ('Ręka GRACZA NUMER '+str(number)).center(r1_for) +'|\n' +'-' * (r1_for)+'\n' + '|' + 'Lp'.center(formatt2[0])+'|'+' name'.center(formatt2[1])+'|'+ 'min_attack'.center(formatt2[2]) + '|' + 'max_attack'.center(formatt2[2]) + '|' + 'defence'.center(formatt2[2]) +'|')             
                    
                    for v in wr:
                              print('|' + str(v[0]).center(formatt2[0])+'|'+ str(v[1]).center(formatt2[1])+'|'+ str(v[2]).center(formatt2[2]+6)+'|'+str(v[3]).center(formatt2[2]+6)+'|'+ str(v[4]).center(formatt2[2]+5)+'|')                    
          
          def back(self):
                    input('\nENTER - powrót do MENU\n')
                    self.menu(                    )
                    
game_main()

 



