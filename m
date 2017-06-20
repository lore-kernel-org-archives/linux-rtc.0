Return-Path: <rtc-linux+bncBDKNBMNKRMJRBOOZUPFAKGQECFFMLLY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x231.google.com (mail-wr0-x231.google.com. [2a00:1450:400c:c0c::231])
        by gmr-mx.google.com with ESMTPS id j75si2789094wmj.1.2017.06.20.02.36.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:36:57 -0700 (PDT)
Received: by mail-wr0-x231.google.com with SMTP id r103so88485270wrb.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:36:57 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	adi-buildroot-devel@lists.sourceforge.net,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Cooper <jason@lakedaemon.net>,
	John Stultz <john.stultz@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Chan <michael.chan@broadcom.com>,
	netdev@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Baruch Siach <baruch@tkos.co.il>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	patches@opensource.wolfsonmicro.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: [rtc-linux] [PATCH 00/51] rtc: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:08 +0200
Message-Id: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.

The goal of this series of patches is ti stop using those two functions
and use instead to safer 64bits ones.

It also remove change .set_mmss to set_mmss64 callback for the same reasons.

Those 51 patches almost clean all the drivers except the few that I haven't
been able to compile because of cross-toolchains issues (au1xxx, mpc5121, ps3,
puv3, sun4v, tx4939, starfire, ls1x ...)

Obviously I don't have all those hardwares in my hands so I have only check
that the patches compile without warnings but it up to each maintainer to
valid them on real hardware.

Benjamin Gaignard (51):
  x86: rtc: stop using rtc deprecated functions
  x86: intel-mid: vrtc: stop using rtc deprecated functions
  net: broadcom: stop using rtc deprecated functions
  rtc: 88pm80x: stop using rtc deprecated functions
  rtc: 88pm860x: stop using rtc deprecated functions
  rtc: ab-b5ze-s3: stop using rtc deprecated functions
  rtc: ab8500: stop using rtc deprecated functions
  rtc: armada38x: stop using rtc deprecated functions
  rtc: at32ap700x: stop using rtc deprecated functions
  rtc: at91sam9: stop using rtc deprecated functions
  rtc: bfin: stop using rtc deprecated functions
  rtc: coh901331: stop using rtc deprecated functions
  rtc: cpcap: stop using rtc deprecated functions
  rtc: da9063: stop using rtc deprecated functions
  rtc: da9063: stop using rtc deprecated functions
  rtc: davinci: stop using rtc deprecated functions
  rtc: digicolor: stop using rtc deprecated functions
  rtc: dm355evm: stop using rtc deprecated functions
  rtc: ds1305: stop using rtc deprecated functions
  rtc: ds1374: stop using rtc deprecated functions
  rtc: ds1511: stop using rtc deprecated functions
  rtc: ds1553: stop using rtc deprecated functions
  rtc: ds1672: stop using rtc deprecated functions
  rtc: ds2404: stop using rtc deprecated functions
  rtc: ep93xx: stop using rtc deprecated functions
  rtc: gemini: stop using rtc deprecated functions
  rtc: imxdi: stop using rtc deprecated functions
  rtc: jz4740: stop using rtc deprecated functions
  rtc: lpc32xx: stop using rtc deprecated functions
  rtc: mv: stop using rtc deprecated functions
  rtc: omap: stop using rtc deprecated functions
  rtc: pcap: stop using rtc deprecated functions
  rtc: pl030: stop using rtc deprecated functions
  rtc: pl031: stop using rtc deprecated functions
  rtc: pm8xxx: stop using rtc deprecated functions
  rtc: rs5c348: stop using rtc deprecated functions
  rtc: sa1100: stop using rtc deprecated functions
  rtc: sh: stop using rtc deprecated functions
  rtc: sirfsoc: stop using rtc deprecated functions
  rtc: snvs: stop using rtc deprecated functions
  rtc: stk17ta8: stop using rtc deprecated functions
  rtc: stmp3xxx: stop using rtc deprecated functions
  rtc: sun6i: stop using rtc deprecated functions
  rtc: sysfs: stop using rtc deprecated functions
  rtc: tegra stop using rtc deprecated functions
  rtc: test: stop using rtc deprecated functions
  rtc: tps6586: stop using rtc deprecated functions
  rtc: vr41xx: stop using rtc deprecated functions
  rtc: wm831x: stop using rtc deprecated functions
  rtc: xgene stop using rtc deprecated functions
  power: suspend test: stop using rtc deprecated functions

 arch/x86/kernel/rtc.c                        |  6 ++--
 arch/x86/platform/intel-mid/intel_mid_vrtc.c |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  2 +-
 drivers/rtc/rtc-88pm80x.c                    | 44 +++++++++++++--------------
 drivers/rtc/rtc-88pm860x.c                   | 40 ++++++++++++-------------
 drivers/rtc/rtc-ab-b5ze-s3.c                 | 45 ++++++++--------------------
 drivers/rtc/rtc-ab8500.c                     | 26 ++++++++--------
 drivers/rtc/rtc-armada38x.c                  | 34 +++++++++------------
 drivers/rtc/rtc-at32ap700x.c                 | 29 ++++++++----------
 drivers/rtc/rtc-at91sam9.c                   | 18 ++++-------
 drivers/rtc/rtc-bfin.c                       | 24 +++++++--------
 drivers/rtc/rtc-coh901331.c                  | 14 +++++----
 drivers/rtc/rtc-cpcap.c                      |  8 ++---
 drivers/rtc/rtc-da9052.c                     |  8 ++---
 drivers/rtc/rtc-da9063.c                     |  8 ++---
 drivers/rtc/rtc-davinci.c                    |  8 ++---
 drivers/rtc/rtc-digicolor.c                  |  4 +--
 drivers/rtc/rtc-dm355evm.c                   |  6 ++--
 drivers/rtc/rtc-ds1305.c                     | 11 +++----
 drivers/rtc/rtc-ds1374.c                     |  6 ++--
 drivers/rtc/rtc-ds1511.c                     |  2 +-
 drivers/rtc/rtc-ds1553.c                     |  2 +-
 drivers/rtc/rtc-ds1672.c                     |  8 ++---
 drivers/rtc/rtc-ds2404.c                     |  8 ++---
 drivers/rtc/rtc-ep93xx.c                     | 10 +++----
 drivers/rtc/rtc-gemini.c                     |  8 ++---
 drivers/rtc/rtc-imxdi.c                      | 16 +++++-----
 drivers/rtc/rtc-jz4740.c                     | 12 ++++----
 drivers/rtc/rtc-lpc32xx.c                    | 19 +++++-------
 drivers/rtc/rtc-mv.c                         |  2 +-
 drivers/rtc/rtc-omap.c                       |  6 ++--
 drivers/rtc/rtc-pcap.c                       | 16 +++++-----
 drivers/rtc/rtc-pl030.c                      | 24 +++++++--------
 drivers/rtc/rtc-pl031.c                      | 31 ++++++++-----------
 drivers/rtc/rtc-pm8xxx.c                     | 22 +++++++-------
 drivers/rtc/rtc-rs5c348.c                    |  4 +--
 drivers/rtc/rtc-sa1100.c                     | 25 +++++++---------
 drivers/rtc/rtc-sh.c                         |  2 +-
 drivers/rtc/rtc-sirfsoc.c                    | 18 +++++------
 drivers/rtc/rtc-snvs.c                       | 14 ++++-----
 drivers/rtc/rtc-stk17ta8.c                   |  2 +-
 drivers/rtc/rtc-stmp3xxx.c                   | 12 ++++----
 drivers/rtc/rtc-sun6i.c                      | 14 ++++-----
 drivers/rtc/rtc-sysfs.c                      | 25 ++++++++--------
 drivers/rtc/rtc-tegra.c                      | 22 +++++++-------
 drivers/rtc/rtc-test.c                       | 17 +----------
 drivers/rtc/rtc-tps6586x.c                   | 26 ++++++++--------
 drivers/rtc/rtc-vr41xx.c                     |  6 ++--
 drivers/rtc/rtc-wm831x.c                     | 28 +++++++----------
 drivers/rtc/rtc-xgene.c                      | 12 ++++----
 kernel/power/suspend_test.c                  |  6 ++--
 51 files changed, 342 insertions(+), 420 deletions(-)

-- 
CC: adi-buildroot-devel@lists.sourceforge.net
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Gregory Clement <gregory.clement@free-electrons.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Jason Cooper <jason@lakedaemon.net>
CC: John Stultz <john.stultz@linaro.org>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Michael Chan <michael.chan@broadcom.com>
CC: netdev@vger.kernel.org
CC: rtc-linux@googlegroups.com
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
CC: Support Opensource <support.opensource@diasemi.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: x86@kernel.org
CC: Baruch Siach <baruch@tkos.co.il>
CC: Hans Ulli Kroll <ulli.kroll@googlemail.com>
CC: Vladimir Zapolskiy <vz@mleia.com>
CC: Sylvain Lemieux <slemieux.tyco@gmail.com>
CC: Barry Song <baohua@kernel.org>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Jonathan Hunter <jonathanh@nvidia.com>
CC: linux-tegra@vger.kernel.org
CC: patches@opensource.wolfsonmicro.com
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Pavel Machek <pavel@ucw.cz>
CC: Len Brown <len.brown@intel.com>
CC: linux-pm@vger.kernel.org

1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
