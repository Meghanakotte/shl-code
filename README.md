# SHL Grammar Scoring Engine - Research Engineer Assessment

## 📋 Overview
This project implements a **Grammar Scoring Engine** that predicts continuous grammar scores (0-5) from 45-60 second spoken audio samples. It combines **speech-to-text transcription** (Whisper ASR), **deep embeddings** (Sentence-BERT + Whisper encoder), and **handcrafted linguistic/audio features** into a powerful ensemble model.

Built as part of SHL's Research Engineer assessment.

## 🎯 Results
- **Cross-Validation RMSE**: 0.5475
- **Cross-Validation Pearson Correlation**: 0.70
- **Best Approach**: Stacking Meta-Learner (Ridge over LightGBM + XGBoost + CatBoost)
- **Total Features**: 942

| Model | CV RMSE | Pearson |
|-------|---------|---------|
| LightGBM | 0.5544 | 0.698 |
| XGBoost | 0.5555 | 0.703 |
| CatBoost | 0.5628 | 0.692 |
| Weighted Ensemble | 0.5528 | 0.707 |
| **Stacking** | **0.5475** | **0.700** |

## 📁 Repository Structure
```
shl-audio-scoring-challenge/
├── Grammar_Scoring_Whisper.ipynb        # Complete solution notebook (v3)
├── submission.csv                        # Test predictions (197 samples)
├── transcriptions_cache/                 # Cached Whisper transcriptions
├── README.md                             # This file
└── dataset/                              # Audio files and labels
    ├── audios/
    │   ├── train/                        # 409 training audio files
    │   └── test/                         # 197 test audio files
    └── csvs/
        ├── train.csv                     # Training labels (0-5 scores)
        └── test.csv                      # Test file names
```

## 🔧 Technical Approach

### 1. Universal Audio Loading
- **ffmpeg integration** via `imageio-ffmpeg` handles ALL audio formats
- Critical fix: 37% of `.wav` files are actually M4A/AAC (disguised with .wav extension)
- Fallback chain: scipy.io.wavfile → ffmpeg subprocess
- Result: **409/409 train, 197/197 test** files loaded (0 failures)

### 2. Speech-to-Text Transcription
- **OpenAI Whisper** (base model) transcribes all audio to English text
- Transcriptions cached to disk for fast re-runs
- Handles noisy audio, accented speech, and varying recording quality

### 3. Feature Pipeline (942 features)

| Category | Count | Description |
|----------|-------|-------------|
| Text/Grammar | 36 | Grammar errors, readability scores, vocabulary richness, sentence complexity, function word rates, filler words |
| Audio/Fluency | 10 | Energy, silence ratio, pitch, speaking rate, pause count, zero-crossing rate |
| SBERT Embeddings | 384 | Sentence-BERT (all-MiniLM-L6-v2) dense text representations |
| Whisper Encoder | 512 | Mean-pooled Whisper encoder hidden states (audio embeddings) |

### 4. Model Ensemble
- **Base models**: XGBoost, LightGBM, CatBoost (800 estimators each, tuned hyperparameters)
- **Stacking**: Ridge meta-learner over 5-fold OOF predictions from top-3 base models
- **Weighted ensemble**: Inverse-RMSE weighted average as alternative
- 5-fold cross-validation with fixed random seed for reproducibility

### 5. Evaluation
- **RMSE**: Primary competition metric
- **Pearson Correlation**: Measures linear relationship strength
- Both computed on out-of-fold predictions for unbiased estimates

## 🚀 How to Run

### Prerequisites
```bash
pip install openai-whisper language-tool-python textstat imageio-ffmpeg \
    sentence-transformers xgboost lightgbm catboost scikit-learn \
    pandas numpy scipy torch tqdm
```

### Execution
```bash
jupyter notebook Grammar_Scoring_Whisper.ipynb
```
Run all cells sequentially. The notebook will:
1. Load Whisper, Sentence-BERT, and LanguageTool models
2. Transcribe all audio files via Whisper (~30 min first run, cached after)
3. Extract 46 handcrafted features (text + audio)
4. Generate 384-dim SBERT + 512-dim Whisper encoder embeddings
5. Train and evaluate 4 models with 5-fold CV
6. Build stacking ensemble and generate `submission.csv`

### Notes
- First run takes ~60 min (transcription + Whisper embeddings)
- Subsequent runs are fast (~10 min) thanks to transcription caching
- Requires ~2GB RAM for models and feature matrices

## 📊 Key Findings
- **37% of audio files** were M4A format disguised as .wav — ffmpeg integration was critical
- Whisper encoder embeddings capture pronunciation/fluency patterns not available in text
- SBERT embeddings outperform bag-of-words approaches for semantic grammar quality
- Stacking meta-learner provides modest but consistent improvement over base models
- Grammar error density and lexical diversity are the most informative handcrafted features

## 📝 Submission Details
- **Assessment**: Grammar Scoring Engine (Option 2)
- **Competition**: Kaggle-hosted audio scoring challenge
- **Output**: 197 continuous predictions in `submission.csv`

## 🛠️ Dependencies
- Python 3.10+
- openai-whisper
- sentence-transformers
- language-tool-python
- textstat
- imageio-ffmpeg
- xgboost, lightgbm, catboost
- scikit-learn, scipy, pandas, numpy
- torch, tqdm

## 👤 Author
Candidate for SHL Research Engineer Position

---
*All code is well-documented and follows best practices for reproducibility.*
