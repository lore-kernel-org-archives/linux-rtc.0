Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:49525 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbeFFPvx (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 6 Jun 2018 11:51:53 -0400
Date: Wed, 6 Jun 2018 17:51:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v3 05/12] rtc: cros-ec: Make license text and module
 license match.
Message-ID: <20180606155151.GO4637@piout.net>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-6-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180606150900.8342-6-enric.balletbo@collabora.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 06/06/2018 17:08:53+0200, Enric Balletbo i Serra wrote:
> The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
> GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
> boiler plate does not match, go for boiler plate license.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/rtc/rtc-cros-ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
