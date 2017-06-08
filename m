Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33673 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdFHBhx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Jun 2017 21:37:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170607152615.2072-1-colin.king@canonical.com>
References: <20170607152615.2072-1-colin.king@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Jun 2017 04:37:52 +0300
Message-ID: <CAHp75VfBLQjtZPgY9pDxu4Lp__u+E+bfS=A6-id9cpPCX_ZQoQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-max8925: remove redundant check on ret
To: Colin King <colin.king@canonical.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jun 7, 2017 at 6:26 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The check on ret < 0 is redundant as the goto destination is the
> next statment.  Remove this redudant check and goto.
>
> Detected by CoverityScan, CID#1268785 ("Identical code for different
> branches")

>                 ret = max8925_reg_write(info->rtc, MAX8925_ALARM0_CNTL, 0x77);
>         else
>                 ret = max8925_reg_write(info->rtc, MAX8925_ALARM0_CNTL, 0x0);
> -       if (ret < 0)
> -               goto out;
>  out:
>         return ret;

...and label (w/ replacing it by inplace return ret;) ?

-- 
With Best Regards,
Andy Shevchenko
