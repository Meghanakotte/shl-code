# SHL Grammar Scoring Engine - Research Engineer Assessment

## 📋 Overview
This project implements a **Grammar Scoring Engine** that predicts continuous grammar scores (0-5) from 45-60 second spoken audio samples. Built as part of SHL's Research Engineer assessment.

## 🎯 Results
- **Cross-Validation RMSE**: 0.728
- **Cross-Validation Pearson Correlation**: 0.318
- **Model Architecture**: Ensemble of 4 tree-based regressors
  - RandomForest (500 trees)
  - ExtraTrees (700 trees)
  - GradientBoosting (400 iterations)
  - HistGradientBoosting (500 iterations)

## 📁 Repository Structure
```
shl-audio-scoring-challenge/
├── Grammar_Scoring_Engine_Submission.ipynb    # Complete solution notebook
├── submission.csv                              # Test predictions (197 samples)
├── README.md                                   # This file
└── dataset/                                    # Audio files and labels
    ├── audios/
    │   ├── train/                             # 409 training audio files
    │   └── test/                              # 197 test audio files
    └── csvs/
        ├── train.csv                          # Training labels
        └── test.csv                           # Test file names
```

## 🔧 Technical Approach

### 1. Audio Feature Engineering
Extracted 72 acoustic features per sample:
- **Time-domain**: Zero-crossing rate, RMS energy
- **Spectral**: Centroid, bandwidth, rolloff, flatness (mean, std, median)
- **Cepstral**: 13 MFCCs + delta-MFCCs (52 features)
- **Duration**: Audio length in seconds

### 2. Model Pipeline
1. Robust audio preprocessing with normalization
2. 5-fold cross-validation for model selection
3. Ensemble averaging for final predictions
4. Clipping outputs to valid range [0, 5]

### 3. Evaluation Metrics
- **RMSE**: Primary metric for model comparison
- **Pearson Correlation**: Measures linear relationship strength
- Both computed on out-of-fold predictions for unbiased estimates

## 🚀 How to Run

### Prerequisites
```bash
pip install librosa pandas scikit-learn matplotlib seaborn tqdm scipy numpy soundfile
```

### Execution
```bash
jupyter notebook Grammar_Scoring_Engine_Submission.ipynb
```
Run all cells sequentially. The notebook will:
1. Load and validate dataset paths
2. Extract audio features (~4-5 min for training set)
3. Train and benchmark 4 models (~30 sec)
4. Generate visualizations
5. Create `submission.csv` with test predictions

## 📊 Key Findings
- Score distribution is centered around 3.0 (most common)
- Audio duration shows weak correlation with grammar scores
- Ensemble slightly outperforms single best model
- Feature extraction is robust (0 errors on 606 total samples)

## 📝 Submission Details
- **Assessment**: Grammar Scoring Engine (Option 2)
- **Deadline**: March 3, 2026, 11:00 AM
- **Competition**: Kaggle-hosted audio scoring challenge
- **Output**: 197 continuous predictions in `submission.csv`

## 🛠️ Dependencies
- Python 3.10+
- librosa >= 0.10.0
- scikit-learn >= 1.3.0
- pandas >= 2.0.0
- numpy >= 1.24.0
- matplotlib >= 3.7.0
- seaborn >= 0.12.0

## 👤 Author
Candidate for SHL Research Engineer Position

---
*All code is well-documented and follows best practices for reproducibility.*
