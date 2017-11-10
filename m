Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59258 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdKJI6W (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 10 Nov 2017 03:58:22 -0500
Date: Fri, 10 Nov 2017 09:58:05 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org
Subject: Re: [PATCH] rtc: Use time64_t variables to set time/alarm from sysfs
Message-ID: <20171110085805.ebbvgm7ist2l3mn7@piout.net>
References: <672d468478f3f67ef22e027460c59918dc581818.1510211132.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <672d468478f3f67ef22e027460c59918dc581818.1510211132.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 09/11/2017 at 15:09:20 +0800, Baolin Wang wrote:
> Use time64_t variables and related APIs for sysfs interfaces to
> support setting time or alarm after the year 2038 on 32-bit system.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/rtc-sysfs.c |   25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
