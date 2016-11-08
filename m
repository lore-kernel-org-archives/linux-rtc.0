Return-Path: <rtc-linux+bncBDFLXENW3AORBCEQQ7AQKGQEGRZEPJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id n18si8931401pfb.2.2016.11.08.04.41.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 04:41:43 -0800 (PST)
Date: Tue, 8 Nov 2016 20:50:06 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: x86@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>,
	Xunlei Pang <xlpang@redhat.com>
Subject: [rtc-linux] Re: [PATCH 1/2][RFC v6] timekeeping: Ignore the bogus
 sleep time if pm_trace is enabled
Message-ID: <20161108125006.GD7191@yu-desktop-1.sh.intel.com>
References: <cover.1478589736.git.yu.c.chen@intel.com>
 <e0ed3331627184f3da6243b00cfa69dd78e85514.1478589736.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <e0ed3331627184f3da6243b00cfa69dd78e85514.1478589736.git.yu.c.chen@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Nov 08, 2016 at 05:01:35PM +0800, Chen Yu wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, and we have fixed it
> in recent kernel. However it's improper in the first place
> to call __timekeeping_inject_sleeptime() in case that pm_trace
> is enabled simply because that "hash" time value will wreckage
> the timekeeping subsystem.
> 
> This patch is to bypass the bogus rtc interval when pm_trace is enabled.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Xunlei Pang <xlpang@redhat.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>
[cut]
Will resend another version. Thanks. 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
