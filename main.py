import io

import matplotlib.font_manager as fm
import matplotlib.pyplot as plt
import numpy as np
from fastapi import FastAPI
from fastapi.responses import Response

app = FastAPI()


@app.get("/plot")
async def generate_plot():
    # Set Thai font
    font_path = "./Garuda.otf"
    prop = fm.FontProperties(fname=font_path)
    # plt.rcParams["font.family"] = "Garuda" # ดูเหมือนถ้าใช้กำหนดค่านี้จะเกิด warning findfont: Font family 'Garuda' not found.

    # Generate sample data
    months = [
        "ม.ค.",
        "ก.พ.",
        "มี.ค.",
        "เม.ย.",
        "พ.ค.",
        "มิ.ย.",
        "ก.ค.",
        "ส.ค.",
        "ก.ย.",
        "ต.ค.",
        "พ.ย.",
        "ธ.ค.",
    ]
    values = np.random.randint(50, 200, 12)

    # Create plot
    plt.figure(figsize=(10, 6))
    plt.plot(months, values, marker="o")

    # Set labels and title
    plt.title("ข้อมูลรายเดือน", fontproperties=prop)  # ให้กำหนดแบบนี้ทุกที่ที่มี font ที่ต้องการใช้
    plt.xlabel("เดือน", fontproperties=prop)
    plt.ylabel("จำนวน", fontproperties=prop)
    plt.grid(True)

    # Rotate x-axis labels for better readability
    plt.xticks(rotation=45, fontproperties=prop)

    # Save plot to bytes buffer
    buf = io.BytesIO()
    plt.savefig(buf, format="png", bbox_inches="tight")
    plt.close()
    buf.seek(0)

    return Response(content=buf.getvalue(), media_type="image/png")
