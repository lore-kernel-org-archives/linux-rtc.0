Return-Path: <rtc-linux+bncBCRIZROPVQPBBC6IVSXAKGQEYLBHBWA@googlegroups.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com. [209.85.192.169])
        by gmr-mx.google.com with ESMTPS id c1si532961pdg.0.2015.08.12.03.46.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2015 03:46:35 -0700 (PDT)
Received: by pdbfa8 with SMTP id fa8so6170362pdb.1
        for <rtc-linux@googlegroups.com>; Wed, 12 Aug 2015 03:46:35 -0700 (PDT)
Date: Wed, 12 Aug 2015 16:16:25 +0530
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
Message-ID: <20150812104625.GB20238@linux>
References: <cover.1439375087.git.viresh.kumar@linaro.org>
 <1a92f2e1af5309ece9736f79f312e90486a98825.1439375087.git.viresh.kumar@linaro.org>
 <20150812104133.GE3411@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150812104133.GE3411@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12-08-15, 12:41, Alexandre Belloni wrote:
> Hi Viresh,
> 
> Why are you resending?

I never got a reply from Andrew Morton on V1, so resent it again. And
today Andrew asked me to take this via trivial tree.

So the resent.

I need to find a sane way to get few more people to the cover-letter.
The problem is that I am generating the cc-list with get_maintainers,
and if I combine that list for all the patches, it becomes huge. And
really can't send the cover-letter to those people then. Few lists may
block it as well, due to high number of cc'd people.

I am telling this because, the cover-letter did contain the reason for
resend.

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
