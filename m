Return-Path: <rtc-linux+bncBCRIZROPVQPBBW7EVSXAKGQEDCTDHFI@googlegroups.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com. [209.85.220.47])
        by gmr-mx.google.com with ESMTPS id eq2si566253pbb.2.2015.08.12.04.47.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2015 04:47:39 -0700 (PDT)
Received: by mail-pa0-f47.google.com with SMTP id gr6so13120357pac.2
        for <rtc-linux@googlegroups.com>; Wed, 12 Aug 2015 04:47:39 -0700 (PDT)
Date: Wed, 12 Aug 2015 17:17:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: trivial@kernel.org, linaro-kernel@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"moderated list:BLACKFIN RTC DRIVER" <adi-buildroot-devel@lists.sourceforge.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V1 Resend 06/10] drivers: rtc: Drop (un)likely
 before IS_ERR(_OR_NULL)
Message-ID: <20150812114732.GE20238@linux>
References: <cover.1439375087.git.viresh.kumar@linaro.org>
 <1a92f2e1af5309ece9736f79f312e90486a98825.1439375087.git.viresh.kumar@linaro.org>
 <20150812104133.GE3411@piout.net>
 <20150812104625.GB20238@linux>
 <20150812114256.GF3411@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150812114256.GF3411@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12-08-15, 13:42, Alexandre Belloni wrote:
> The fact is that I sent you a mail yesterday stating that I applied that
> particular patch.

Urg ..

I looked at the 'V1 Resend' series to see which all are applied, and
missed your reply on the first version.

Sorry about that.

-- 
viresh

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
