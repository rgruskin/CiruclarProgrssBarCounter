//
//  ContentView.swift
//  CicularProgressBar
//
//  Created by Rich Gruskin on 3/20/21.
//

import SwiftUI


struct ContentView: View {
    
    @State var percentage : CGFloat = 85
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    @State var timer: Timer? = nil
    @State var timerIsPaused: Bool = true
    
    var body: some View {
        
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ZStack {
                    Pulsation()
                    Track()
                    Outline(seconds: seconds)
                    Label(hours: hours, minutes: minutes, seconds: seconds)
                }
                Spacer()
                HStack(spacing: 30) {
                    Button (action: {
                        //self.percentage = CGFloat(85)
                        startTimer()
                    }) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                    }
                
                    Button (action: {
                        //self.percentage = CGFloat(0)
                        stopTimer()
                    }) {
                        Image(systemName: "arrowshape.turn.up.backward.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                    }
                }
        }
        }
    }
    
    func stopTimer(){
      timerIsPaused = true
      timer?.invalidate()
      timer = nil
    }

    func startTimer(){
      timerIsPaused = false
      // 1. Make a new timer
      timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
        // 2. Check time to add to H:M:S
        if self.seconds == 59 {
          self.seconds = 0
          if self.minutes == 59 {
            self.minutes = 0
            self.hours = self.hours + 1
          } else {
            self.minutes = self.minutes + 1
          }
        } else {
          self.seconds = self.seconds + 1
        }
      }
    }
}


struct Pulsation : View {
    
    @State var pulsate  = false
    
    var colors: [Color] = [Color.pulsatingColor]
    
    var body: some View {
        Circle()
            .fill(Color.pulsatingColor)
            .frame(width: 245, height: 245)
            .scaleEffect(pulsate ? 1.3 : 1.0)
            .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true))
            .onAppear {
                self.pulsate.toggle()
            }
        
    }
}

struct Outline : View {
    var seconds : Int
    var colors : [Color] = [Color.outlineColor]
    var body: some View {

        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height: 250)
                .overlay(
                    Circle()
                        .trim(from: 0, to: CGFloat(seconds) * 0.016)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
                )
                //.animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
        }

  }
}

struct Track : View {
    var colors : [Color]  = [Color.trackColor]
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.backgroundColor)
                .frame(width: 250, height: 250)
                .overlay(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth:20))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center))
                )
            }
    }
}

struct Label: View {
    //var percentage : CGFloat = 0
    var hours : Int
    var minutes : Int
    var seconds : Int
    
    var body : some View {
        ZStack {
            //Text (String(format: "%.0f", percentage))
            Text("\(hours):\(minutes):\(seconds)")
                .font (.system(size: 40))
                .fontWeight(.heavy)
                .colorInvert()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
