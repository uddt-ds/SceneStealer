//
//  MovieDetailHeaderView.swift
//  SceneStealer
//
//  Created by Lee on 8/2/25.
//

import UIKit

class MovieDetailHeaderView: UITableViewHeaderFooterView, InitialViewProtocol {

    lazy var imageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .primaryDrakGray
        return collectionView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.pageIndicatorTintColor = .primaryGray
        return pageControl
    }()

    private let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        let image = ImageSystem.getImage(name: ImageSystem.calendar.rawValue)
        imageView.image = image
        imageView.tintColor = .primaryGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = .subTitleM
        return label
    }()

    private lazy var calendarStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calendarImageView, calendarLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        let image = ImageSystem.getImage(name: ImageSystem.star.rawValue)
        imageView.image = image
        imageView.tintColor = .primaryGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let starLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = .subTitleM
        return label
    }()

    private lazy var starStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starImageView, starLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private let genreImageView: UIImageView = {
        let imageView = UIImageView()
        let image = ImageSystem.getImage(name: ImageSystem.film.rawValue)
        imageView.image = image
        imageView.tintColor = .primaryGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = .subTitleM
        return label
    }()

    private lazy var genreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreImageView, genreLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private let splitView1: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryGray
        return view
    }()

    private let splitView2: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryGray
        return view
    }()

    private let leadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let trailingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leadingView, calendarStackView, splitView1, starStackView, splitView2, genreStackView, trailingView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureHierarchy() {
        [imageCollectionView, pageControl, totalStackView].forEach { addSubview($0) }
    }

    func configureLayout() {
        imageCollectionView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
        }

        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(totalStackView.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }

        [calendarImageView, starImageView, genreImageView].forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(20)
            }
        }

        [calendarLabel, starLabel, genreLabel].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
        }

        [leadingView, trailingView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
        }

        trailingView.snp.makeConstraints { make in
            make.width.equalTo(leadingView)
        }

        leadingView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        trailingView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        [splitView1, splitView2].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(1)
                make.height.equalTo(20)
            }
        }

        totalStackView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }

    func configureView() {
        backgroundConfiguration?.backgroundColor = .clear
        tintColor = .primaryBlack
    }

    private func makeCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
        return layout
    }

    func configureView(data: MovieDetailModel) {
        calendarLabel.text = data.releaseDate
        starLabel.text = data.shortVoteAverage
        genreLabel.text = data.genre
    }
}
