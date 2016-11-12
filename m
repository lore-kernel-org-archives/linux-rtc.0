Return-Path: <rtc-linux+bncBDL53MW2W4EBBDO3TPAQKGQE36MFOUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com. [2607:f8b0:4001:c0b::243])
        by gmr-mx.google.com with ESMTPS id p84si2166999itg.1.2016.11.12.02.23.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Nov 2016 02:23:09 -0800 (PST)
Received: by mail-it0-x243.google.com with SMTP id b123so2285000itb.2
        for <rtc-linux@googlegroups.com>; Sat, 12 Nov 2016 02:23:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Date: Sat, 12 Nov 2016 12:23:08 +0200
Message-ID: <CAKP5S=1YeLRqun5ABjYRk=be1fVBGJPqo_nOC1oYmnguG0+jpg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/3] rtc: rtc-twl: cleanup
To: Tony Lindgren <tony@atomide.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, Nov 12, 2016 at 12:07 PM, Nicolae Rosia
<Nicolae_Rosia@mentor.com> wrote:
> This is a cleanup and preparation of rtc-twl to reduce the usage of
> twl-core exported functions.
> The next patch series will further reduce the usage of exported functions
> but first it requires some changes in mfd/twl-core.c
Tony, could you please test this series again and add your Tested-By ?

Thanks a lot,
Nicolae

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
