//
//  ViewController.swift
//  FishTank
//
//  Created by Prashant Saund on 2/8/17.
//  Copyright © 2017 MyOrg. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var playSound : AVAudioPlayer!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        GlassImg.image = #imageLiteral(resourceName: "fishglass")
        //First the button and slider, then the glass
        numFish.layer.zPosition = 1.0
        RoundBorder.layer.zPosition = 1.0
        GlassImg.layer.zPosition=0.9
    
        RoundBorder.layer.cornerRadius = 4
        
        starfish() //Generates starfish
        
        //Generates 25 bubbles
        for numb in 1...25
        {
            generateBubbles()
        }
        generateseaweed()

    
    }
    
    var rightFish = [#imageLiteral(resourceName: "fish1R"),#imageLiteral(resourceName: "fish2R"),#imageLiteral(resourceName: "fish3R"),#imageLiteral(resourceName: "fish4R"),#imageLiteral(resourceName: "fish5R"),#imageLiteral(resourceName: "fish6R"), #imageLiteral(resourceName: "fish7R"),#imageLiteral(resourceName: "fish8R"),#imageLiteral(resourceName: "fish9R")]
    var leftFish = [#imageLiteral(resourceName: "fish1L"),#imageLiteral(resourceName: "fish2L"),#imageLiteral(resourceName: "fish3L"),#imageLiteral(resourceName: "fish4L"),#imageLiteral(resourceName: "fish5L"),#imageLiteral(resourceName: "fish6L"),#imageLiteral(resourceName: "fish7L"),#imageLiteral(resourceName: "fish8L"),#imageLiteral(resourceName: "fish9L")]

    @IBOutlet var GlassImg: UIImageView!
    @IBOutlet var numFish: UISlider!
    @IBOutlet var RoundBorder: UIButton!
    @IBOutlet var seaweedImg1: UIImageView!
    @IBOutlet var seaweedImg2: UIImageView!
    @IBOutlet var redSw: UIImageView!
    
    func starfish()
    {
        let wstar = 90
        let hstar = 90
        let xPos = 630          //X-position of starfish
        let yPos = 100          //Y-position of starfish
        
        let star = UIImageView()
        star.image = #imageLiteral(resourceName: "redStarfish")
        star.frame = CGRect(x: xPos, y: yPos, width: wstar, height: hstar)
        self.view.addSubview(star)
        star.layer.zPosition = 0.8
        
        UIView.animate(withDuration: 30.0, delay: 0, options: [.autoreverse, .repeat], animations:
            {() -> Void in
            let transform: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            star.transform = transform
        }, completion: {(finished: Bool) -> Void in
            let transform: CGAffineTransform = CGAffineTransform.identity
            star.transform = transform;
        })
    
    }
    
    
    func generateBubbles()
    {
        let wBubble = (Int(arc4random() % 10) + 1) * 3    //Bubble width between 3 to 30
        let hBubble = (wBubble * 3) / 4                   //height 75% of width
        let xPos = (Int(arc4random() % 706))     //Bubble starts at different horizontal spot
        let yStart = (Int(arc4random() % 90)+300)         //starts on bottom
        let yEnd = 0                                      //ends on top
                
        let bb = UIImageView()
        bb.image = #imageLiteral(resourceName: "bubble")
        bb.frame = CGRect(x: xPos, y: yStart, width: wBubble, height: hBubble)
        self.view.addSubview(bb)
        
        //bubbles behind the button and slider 
        bb.layer.zPosition = 0.7
        
        //duration for animation
        let aDur = Double(arc4random() % 10)+5         //duration between 5-15 seconds
        
        
        UIView.animate(
            withDuration: aDur,
            animations: {bb.frame = CGRect(x: xPos, y: yEnd, width: wBubble, height:hBubble)},
            completion: {animationFinished in bb.removeFromSuperview(); self.generateBubbles()}
        )
    }
    
    
    func generateseaweed()
    {
        seaweedImg1.layer.zPosition=0.8
        
        UIView.animate(withDuration: 10.0, delay: 0, options: [.autoreverse, .repeat], animations:
            {() -> Void in
                let transform: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(M_PI/40))
                self.seaweedImg1.transform = transform
        }, completion: {(finished: Bool) -> Void in
            let transform: CGAffineTransform = CGAffineTransform.identity
            self.seaweedImg1.transform = transform; })

        UIView.animate(withDuration: 10.0, delay: 0, options: [.autoreverse, .repeat], animations:
            {() -> Void in
                let transform: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/40))
                self.seaweedImg2.transform = transform
        }, completion: {(finished: Bool) -> Void in
            let transform: CGAffineTransform = CGAffineTransform.identity
            self.seaweedImg2.transform = transform; })
        
        UIView.animate(withDuration: 10.0, delay: 0, options: [.autoreverse, .repeat], animations:
            {() -> Void in
                let transform: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/40))
                self.redSw.transform = transform
        }, completion: {(finished: Bool) -> Void in
            let transform: CGAffineTransform = CGAffineTransform.identity
            self.redSw.transform = transform; })

        

    }
    
    
    //Function moveRight : Fish move to the right
    func moveRight(ypos: Int, heightfish: Int, widthfish: Int, numberfish: Int)
    {
        let xStart = 0                                  //starts outside of left edge
        let xEnd = 736 - widthfish                      //ends outside of right edge

        
        let fishr = UIImageView()
        fishr.image = rightFish[numberfish]
        fishr.frame = CGRect(x: xStart, y: ypos, width: widthfish, height: heightfish)
        self.view.addSubview(fishr)
        
        
        //duration and delay for animation
        let aDur = Double(arc4random() % 15)+5         //duration between 5-20 seconds
        let aDelay = Double(arc4random() % 2)          // delay between 0 and 1 sec

        UIView.animate(
            withDuration: aDur,
            delay: aDelay,
            animations: {
                fishr.frame = CGRect(x: xEnd, y: ypos, width: widthfish, height:heightfish)
                        },
            completion: {
                animationFinished in fishr.removeFromSuperview();
                self.moveLeft(ypos: ypos, heightfish: heightfish, widthfish: widthfish, numberfish: numberfish)}
        )
    }

    
    //Function moveLeft : Fish move to the left
    func moveLeft(ypos: Int, heightfish: Int, widthfish: Int, numberfish: Int)
    {
        let xStart = 736 - widthfish                      //starts outside of right edge
        let xEnd = 0                                      //ends outside of left edge

        let fishl = UIImageView()
        fishl.image = leftFish[numberfish]
        fishl.frame = CGRect(x: xStart, y: ypos, width: widthfish, height: heightfish)
        self.view.addSubview(fishl)
        

        //duration and delay for animation
        let aDur = Double(arc4random() % 15)+5         // duration between 5-20 seconds
        let aDelay = Double(arc4random() % 2)          // delay between 0 and 1 sec

        UIView.animate(
            withDuration: aDur,
            delay: aDelay,
            animations: {
                fishl.frame = CGRect(x: xEnd, y: ypos, width: widthfish, height:heightfish)},
            completion: {
                animationFinished in fishl.removeFromSuperview();
                self.moveRight(ypos: ypos, heightfish: heightfish, widthfish: widthfish, numberfish: numberfish)})

    }
    
    

    @IBAction func animateFish(_ sender: Any)
    {
        let path = Bundle.main.path(forResource: "wave", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            playSound = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
        
        let noOfFish = Int(roundf(self.numFish!.value)) //Number of fishes= slider
    
         for fish in 1...noOfFish
         {
            let wFish = (Int(arc4random() % 10) + 10) * 6   //fish width between 60 to 114
            let hFish = (wFish * 3) / 4                     //height 75% of width
            let yPos = (Int(arc4random() % 290))            //fish starts at different vertical spot
            
            let fishnumber = Int(arc4random() % 9)          //Selects a random fish from the array
            
            //Calls function moveRight
            moveRight(ypos: yPos, heightfish: hFish, widthfish: wFish, numberfish: fishnumber)
        
        }
    }

}
