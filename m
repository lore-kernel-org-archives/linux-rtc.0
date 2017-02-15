Return-Path: <rtc-linux+bncBDJIP47K7MERB3E6SPCQKGQEMAYLCFY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com. [74.125.82.193])
        by gmr-mx.google.com with ESMTPS id i189si1450159iti.0.2017.02.15.14.00.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2017 14:00:12 -0800 (PST)
Received: by mail-ot0-f193.google.com with SMTP id 73so22108186otj.1
        for <rtc-linux@googlegroups.com>; Wed, 15 Feb 2017 14:00:12 -0800 (PST)
Date: Wed, 15 Feb 2017 16:00:10 -0600
From: Rob Herring <robh@kernel.org>
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, rtc-linux@googlegroups.com,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH 1/2] power: reset: syscon-poweroff: add a mask property
Message-ID: <20170215220010.psk37r4belykyquy@rob-hp-laptop>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Feb 07, 2017 at 05:56:05PM +0200, Guy Shapiro wrote:
> Make the syscon-poweroff driver accept value and mask instead of
> just value.
> 
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> ---
>  .../bindings/power/reset/syscon-poweroff.txt          | 11 +++++++++--
>  drivers/power/reset/syscon-poweroff.c                 | 19 ++++++++++++++++---
>  2 files changed, 25 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
