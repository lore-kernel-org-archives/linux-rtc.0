Return-Path: <rtc-linux+bncBDFLXENW3AORBLNEQ3AQKGQEI3VCRDY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTPS id n18si8678066pfb.2.2016.11.08.00.51.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 00:51:56 -0800 (PST)
From: Chen Yu <yu.c.chen@intel.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Xunlei Pang <xlpang@redhat.com>,
	linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [rtc-linux] [PATCH 0/2][RFC v6] Ignore bogus sleep time if pm_trace
 is enabled
Date: Tue,  8 Nov 2016 17:00:10 +0800
Message-Id: <cover.1478589736.git.yu.c.chen@intel.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch set is based on Thomas's previous solution, to bypass
the bogus CMOS-RTC sleep time after resumed, thus to avoid damage
to timekeeping system. The bogus sleep time comes from pm_trace,
which might use CMOS-RTC for debugging purpose.

Meanwhile, a solution to save/restore of CMOS-RTC is also proposed to give
better user experience. 

Chen Yu (2):
  timekeeping: Ignore the bogus sleep time if pm_trace is enabled
  PM / sleep: save/restore RTC time after resumed if pm_trace enabled

 arch/x86/kernel/rtc.c       |  9 +++++++++
 drivers/base/power/trace.c  | 31 +++++++++++++++++++++++++++++++
 drivers/rtc/rtc-cmos.c      |  7 +++++++
 include/linux/mc146818rtc.h |  1 +
 include/linux/pm-trace.h    |  9 ++++++++-
 5 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
