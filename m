Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56297 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbdJCNcA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 3 Oct 2017 09:32:00 -0400
Date: Tue, 3 Oct 2017 15:31:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: clarify the RTC offset correction
Message-ID: <20171003133158.db4eibi6xqdtvbxg@piout.net>
References: <E1dxsS5-0006RD-Sy@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1dxsS5-0006RD-Sy@rmk-PC.armlinux.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 29/09/2017 at 11:23:25 +0100, Russell King wrote:
> The RTC offset correction documentation is not very clear about the
> exact relationship between "offset" and the effect it has on the RTC.
> Supplement the documentation with an equation giving the relationship.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/rtc/interface.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 8cec9a02c0b8..045e0a72d14b 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -1004,6 +1004,10 @@ int rtc_read_offset(struct rtc_device *rtc, long *offset)
>   * to compensate for differences in the actual clock rate due to temperature,
>   * the crystal, capacitor, etc.
>   *
> + * The adjustment applied is as follows:
> + *   t = t0 * (1 + offset * 1e-9)
> + * where t0 is the measured length of 1 RTC second with offset = 0
> + *

More documentation is available in Documentation/rtc.txt. Maybe it is
worth having the formula in both.


>   * Kernel interface to adjust an rtc clock offset.
>   * Return 0 on success, or a negative number on error.
>   * If the rtc offset is not setable (or not implemented), return -EINVAL
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
