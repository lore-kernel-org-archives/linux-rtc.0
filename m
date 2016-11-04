Return-Path: <rtc-linux+bncBDAYD2P3QYGRBS5C6HAAKGQETRDZDBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com. [2a00:1450:400c:c09::22e])
        by gmr-mx.google.com with ESMTPS id y7si338754wme.0.2016.11.04.02.13.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Nov 2016 02:13:46 -0700 (PDT)
Received: by mail-wm0-x22e.google.com with SMTP id a197so37043464wmd.0
        for <rtc-linux@googlegroups.com>; Fri, 04 Nov 2016 02:13:46 -0700 (PDT)
Subject: [rtc-linux] Re: [RFC PATCH 1/3] ARM64: meson: Add Amlogic Meson GX PM Suspend
To: Sudeep Holla <sudeep.holla@arm.com>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <1478183365-23708-2-git-send-email-narmstrong@baylibre.com>
 <20161103215347.GA23902@e106835-lin.cambridge.arm.com>
Cc: khilman@baylibre.com, carlo@caione.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rtc-linux@googlegroups.com
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <853a192a-520c-d939-88c3-6684e6e5e902@baylibre.com>
Date: Fri, 4 Nov 2016 10:13:42 +0100
MIME-Version: 1.0
In-Reply-To: <20161103215347.GA23902@e106835-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/03/2016 10:53 PM, Sudeep Holla wrote:
> 
> Short response to this patch: NAK
> 
> To be constructive, since this system lacks PSCI system suspend, it just
> can't support. Alternatively, this can be normal cpuidle state and you
> can use suspend to idle to achieve the same and you need not hack/work
> around using platform specific driver.
> 
> --
> Regards,
> Sudeep
> 

Hi Mark, Sudeep,

Thanks for your replies.
First of all, I never intended to have this patchset Acked, I certainly know this is a bad hack !

But, in the current Linux PSCI implementation, there is no way to handle System Suspend when the
SoC FW implements PSCI 0.2, except idle-to-suspend which is quite different since the FW does not handle the wakeup.

Don't worry, I'll prefer Amlogic to conform to PSCI 1.0, but like the SCPI, the GXBB was implemented
using an early version of these FW protocols... and the SoC is here and should be supported somehow.

I have a simple question : Could it be possible to declare an idle-state to be used exclusively by suspend-to-mem ?
For example while parsing the idle-states, if we encounter a particular property, the we save the state, don't
add it to the cpuidle states and register a platform_suspend_ops using this state.

Would it be accepted to be able to select a declared DT idle-state and reserve it to suspend-to-mem state ?

In the Amlogic case, their CPU_SUSPEND is partially conform, but since the power_state parameter was left as
implementation defined, they added a deeper cluster sleep state.
But potentially, we could need to handle system suspend on PSCI0.2 systems using a particular idle-state ?

Yes, Sudeep mentioned suspend-to-idle, but in our tests the kernel enters each idle-state at boot time and when
we declare this deep sleep idle state, it makes the whole system enter this system suspend state.

Neil

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
