Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35102 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbdHYIdw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 04:33:52 -0400
Date: Fri, 25 Aug 2017 10:33:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] rtc: sun6i: Add support for the external
 oscillator gate
Message-ID: <20170825083351.2itpzyyo6ilxt36p@piout.net>
References: <20170825074202.18743-1-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825074202.18743-1-maxime.ripard@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 25/08/2017 at 09:42:02 +0200, Maxime Ripard wrote:
> The RTC can output its 32kHz clock outside of the SoC, for example to clock
> a WiFi chip.
> 
> Create a new clock that other devices will be able to retrieve, while
> maintaining the DT stability by providing a default name for that clock if
> clock-output-names doesn't list one.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/sun6i-rtc.txt          |  4 ++--
>  drivers/rtc/rtc-sun6i.c                            | 24 +++++++++++++++++++---
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
