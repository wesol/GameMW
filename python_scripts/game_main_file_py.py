# -*- coding: utf-8  -*-

import pymysql
import  Password.password

class game_first:         
          
          def __init__(self):
                    # łączenie się z bazą
                    password = Password.password.password
                    self.conn = pymysql.connect('localhost','root',password, 'gameMW')
                    self.cursor = self.conn.cursor()
                    input(' Witajcie w grze. Aby przejść do MENU wciśnij "Enter"')
                    self.menu()
                    #self.registration()
                    #self.ranking()
          
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
                              self.kards()
                    elif action == 'V':
                              self.ranking()
                    elif action == 'Q':
                              self.quit()
                    elif action == 'A12':
                              self.admPanel()                    
                    
          def newGame(self):
                    print ('Aby rozpocząć grę, należy wprowadzić dane logowania')
                    self.back()
          def registration(self):
                    while True:
                              #action = input('Wprowadzenie danych nowego użytkownika.\nPo rejestracji będziesz mógł pracować nad poprawieniem swojego rankingu\nJeśli nie chcesz się rejestrować, wprowadź "M" aby wyjść do MENU').upper()
                              #if action == 'M':
                              #self.menu()
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
                    print ('obejrzenie kart')
                    self.back()
          def ranking(self):
                    formatt = [20,30,30,20,20] #szerokość kolumn
                    print('\nOto aktualny ranking:\n'+'-' * (sum(formatt)+15)+'\n' +
                          '|' + 'login'.center(formatt[0])+'|'+ ' first_log'.center(formatt[1]+11)+'|'+' last_log'.center(formatt[2]+11)+'|'+ 'plays'.center(formatt[3]-4)+'|'+  'wons'.center(formatt[4]-4) +'|\n'
                          +'-'*(sum(formatt)+15))
                    self.cursor.execute("select * from all_players where login != 'guest' and login != 'guest2'")
                    #self.cursor.execute("select * from all_players") #test
                    #print(self.cursor.fetchall()) #test
                    self.back()
                    for v in self.cursor.fetchall():
                              login = v[0]
                              first_log = v[1]                                        
                              last_log = v[2]                                        
                              plays = v[3]
                              wons = v[4]
                              print('|'+v[0].center(formatt[0])+'|'+ str(first_log).center(formatt[1])+'|'+ str(last_log).center(formatt[2])+'|'+ str(plays).center(formatt[3])+'|'+  str(wons).center(formatt[4])+'|')             
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
                    
          def back(self):
                    input('\nENTER - powrót do MENU\n')
                    self.menu()
game_first()

 



