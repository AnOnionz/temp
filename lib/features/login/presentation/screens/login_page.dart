
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/common/constants.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/login/presentation/blocs/login_bloc.dart';



class LoginPage extends StatefulWidget {

  const LoginPage({Key? key,}) : super(key: key);


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ctlUserName = TextEditingController(text: 'userbaocao') ;
  TextEditingController ctlPassword =  TextEditingController(text: '123456');
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    ctlUserName.dispose();
    ctlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: .3,
            heightFactor: .6,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: size.width *.15,),
                    const SizedBox(height: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tài khoản', style: kBlackSmallSmallText,),
                        const SizedBox(height: 4.0,),
                        Container(
                          height: 37,
                          width: size.width *.3 /1.8,
                          child: TextFormField(
                            controller: ctlUserName,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:  Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: kGreyColor.withOpacity(0.9),
                                      width: 1,
                                      style: BorderStyle.none
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: kGreyColor,
                                    width: 1,
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: kGreyColor,
                                    width: 1,
                                  )
                              ),
                              errorBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    width: 1,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                        const SizedBox(height: 20,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mật khẩu', style: kBlackSmallSmallText,),
                              const SizedBox(height: 4.0,),
                              Container(
                                height: 37,
                                width: size.width *.3 /1.8,
                                child: TextFormField(
                                  controller: ctlPassword,
                                  obscuringCharacter: '*',
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:  Colors.white,
                                    suffixIcon: InkWell(
                                      onTap: _toggle,
                                      child: Container(
                                        child: _obscureText ? Icon(Icons.visibility, size: 20,) : Icon(Icons.visibility_off,size: 20,),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: kGreyColor.withOpacity(0.9),
                                            width: 1,
                                            style: BorderStyle.none
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: kGreyColor,
                                          width: 1,
                                        )
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: kGreyColor,
                                          width: 1,
                                        )
                                    ),
                                    errorBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.redAccent,
                                          width: 1,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        BlocConsumer<LoginBloc, LoginState>(
                          bloc: Modular.get<LoginBloc>(),
                          listener: (context, state) {
                              if(state is LoginSuccess){
                                Modular.get<AuthenticationBloc>().add(LoggedIn(loginEntity: state.user));
                              }
                            },
                            builder: (context, state) {
                              if(state is LoginLoading){
                                return Container(
                                  height: 37,
                                  width: size.width *.3 /1.8,
                                  decoration: BoxDecoration(
                                    color: kGreenColor,
                                    borderRadius: BorderRadius.circular(5.0),

                                  ),
                                  child: Center(child: Container(height: 20, width:20, child: CircularProgressIndicator())),
                                );
                              }
                              return InkWell(
                                onTap: (){
                                  Modular.get<LoginBloc>().add(LoginButtonPress(username: ctlUserName.text, password: ctlPassword.text));
                                },
                                child: Container(
                                  height: 37,
                                  width: size.width *.3 /1.8,
                                  decoration: BoxDecoration(
                                    color: kGreenColor,
                                    borderRadius: BorderRadius.circular(5.0),

                                  ),
                                  child: Center(child: Text('Đăng nhập', style: kWhiteSmallText,)) ,
                                ),
                              );
                            },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
}
