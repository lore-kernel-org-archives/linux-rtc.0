Return-Path: <rtc-linux+bncBDA7X7F2WUEBBLVOTK7AKGQEDEMJJBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id p199si2252259wmd.1.2016.08.31.01.37.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 01:37:02 -0700 (PDT)
Received: by mail-wm0-x22f.google.com with SMTP id 1so24918845wmz.1
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 01:37:02 -0700 (PDT)
Date: Wed, 31 Aug 2016 09:38:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] [GIT PULL] Immutable branch between MFD, Regulator and RTC
Message-ID: <20160831083849.GQ10121@dell>
References: <1470921406-18468-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1470921406-18468-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Enjoy!

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d=
:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-reg=
ulator-rtc-v4.9

for you to fetch changes up to ddc085d44dd001e65eecd0a8bf05064bff063668:

  regulator: qcom_rpm-regulator: Add support for pm8018 rpm regulator (2016=
-08-31 09:33:54 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Regulator and RTC due for the v4.9 merge wind=
ow.

----------------------------------------------------------------
Neil Armstrong (4):
      mfd: pm8921: Add support for pm8018
      rtc: rtc-pm8xxx: Add support for pm8018 rtc
      mfd: qcom-rpm: Add support for pm8018 RPM Regulator
      regulator: qcom_rpm-regulator: Add support for pm8018 rpm regulator

 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |  1 +
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 15 +++++
 drivers/mfd/pm8921-core.c                          |  1 +
 drivers/mfd/qcom_rpm.c                             | 51 +++++++++++++++++
 drivers/regulator/qcom_rpm-regulator.c             | 66 ++++++++++++++++++=
++++
 drivers/rtc/rtc-pm8xxx.c                           |  1 +
 include/dt-bindings/mfd/qcom-rpm.h                 | 22 ++++++++
 7 files changed, 157 insertions(+)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
