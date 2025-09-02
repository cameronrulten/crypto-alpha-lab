PY:=uv run
.PHONY: install ingest train backtest serve dashboard

install:
	uv sync

ingest:
	$(PY) python -m src.ingest.price_fetcher --config configs/data.yaml

train:
	$(PY) python -m src.models.baselines --config configs/model.yaml

backtest:
	$(PY) python -m src.backtest.engine --config configs/model.yaml

serve:
	$(PY) uvicorn src.api.serve:app --host 0.0.0.0 --port 8001 --reload

dashboard:
	$(PY) streamlit run src.app.dashboard.py
