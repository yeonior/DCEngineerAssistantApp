//
//  ViewController.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 08.04.2021.
//

import UIKit

class ConverterVC: UIViewController {
    
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        return scrollView
//    }()
//    let pageControl: UIPageControl = {
//        let pageControl = UIPageControl()
//        pageControl.numberOfPages = 3
//        pageControl.backgroundColor = .systemBackground
//        pageControl.pageIndicatorTintColor = .lightGray
//        pageControl.currentPageIndicatorTintColor = .black
//        return pageControl
//    }()
//    let label: UILabel = {
//        let label = UILabel()
//        label.text = "1 FT"
//        label.font = UIFont.systemFont(ofSize: 50)
//        label.textAlignment = .center
//        label.backgroundColor = .green
//        return label
//    }()
    
    fileprivate var method: ConvertMethod = .ft
    fileprivate var firstValue: Int = 1 {
        didSet {
            firstLabel.text = "\(firstValue) " + (method == .ft ? "ft" : "m")
        }
    }
    
    fileprivate var secondValue: Double = 0.3 {
        didSet {
            secondLabel.text = "\(secondValue) " + (method == .ft ? "m" : "ft")
        }
    }

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(scrollView)
//        view.addSubview(pageControl)
        
//        scrollView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        
//        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        convert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        convert()
    }
    
//    override func viewDidLayoutSubviews() {
//
//        scrollView.frame = CGRect(x: 0,
//                                  y: view.safeAreaInsets.top,
//                                  width: view.frame.size.width,
//                                  height: view.safeAreaLayoutGuide.layoutFrame.size.height)
//
//        pageControl.frame = CGRect(x: view.frame.size.width / 2 - 61,
//                                   y: view.frame.size.height - view.safeAreaInsets.bottom,
//                                   width: 122,
//                                   height: -40)
//
//        configureScrollView()
//
//    }
    
//    @objc func pageControlDidChange(_ sender: UIPageControl) {
//
//        let currentPage = sender.currentPage
//        scrollView.setContentOffset(CGPoint(x: view.frame.size.width * CGFloat(currentPage),
//                                            y: 0),
//                                    animated: true)
//    }

//    private func configureScrollView() {
//        let pageCount = 3
//        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(pageCount),
//                                        height: scrollView.frame.size.height)
//        scrollView.isPagingEnabled = true
//        let colors: [UIColor] = [
//            .yellow,
//            .blue,
//            .brown
//        ]
//        for i in 0..<pageCount {
//            let page = UIView(frame: CGRect(x: CGFloat(i) * view.frame.size.width,
//                                            y: 0,
//                                            width: view.frame.size.width,
//                                            height: scrollView.frame.size.height))
//            page.backgroundColor = colors[i]
//            scrollView.addSubview(page)
//        }
//        let label = self.label
//        label.frame = CGRect(x: view.frame.size.width / 2 - 100, y: 50, width: 200, height: 100)
//        scrollView.addSubview(label)
//    }
    
    // convertation
    fileprivate func convert() {
                
        var coef = 0.3048
        
        switch method {
        case .ft:
            coef = 0.3048
        case .m:
            coef = 3.28084
        }
        
        let value = pickerView.selectedRow(inComponent: 1) + 1
        let convertedResult = round(Double(value) * coef * 100) / 100
        
        firstValue = value
        secondValue = convertedResult
    }
}

extension ConverterVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 2
        } else {
            return 100
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if row == 0 {
                return "ft"
            } else {
                return "m"
            }
        } else {
            return "\(row + 1)"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 && row == 0 {
            method = .ft
        } else if component == 0 && row == 1 {
            method = .m
        }
        
        convert()
    }
}

enum ConvertMethod {
    case ft, m
}

//extension ConverterVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        pageControl.currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
//    }
//}
