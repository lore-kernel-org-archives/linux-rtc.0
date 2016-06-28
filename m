Return-Path: <rtc-linux+bncBDAYD2P3QYGRBJ6LZC5QKGQEP4W6OUI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id q124si431191wme.3.2016.06.28.00.22.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 00:22:15 -0700 (PDT)
Received: by mail-wm0-x235.google.com with SMTP id a66so13356791wme.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Jun 2016 00:22:15 -0700 (PDT)
Subject: [rtc-linux] Re: AMLogic RTC series (second round)
To: Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-kernel@lists.codethink.co.uk, rtc-linux@googlegroups.com,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 devicetree@vger.kernel.org
References: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
Cc: linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
 frowand.list@gmail.com
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <577225A3.9010409@baylibre.com>
Date: Tue, 28 Jun 2016 09:22:11 +0200
MIME-Version: 1.0
In-Reply-To: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/27/2016 06:44 PM, Ben Dooks wrote:
> Apologies, forgot to put the RTC driver through checkpatch
> before sending. This gets rid of most of the warnings.
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

Hi Ben,

The patchset looks good but misses some quick introduction on how
the RTC works, it seems to be connected to an internal serial bus,
do you have some informations about this ?

Then, the cover letter of your patchset should contain much more informations
that "git format-patch --cover-letter" generates.

My personal workflow when I have a set ready is :

* run checkpatch on C files and check my changes
# scripts/checkpatch.pl -f path/to/my/driver.c
* I identify the number of patches to include
* I generate the patches with cover-letter, signoff and eventually subject-prefix, here for 4 commits
# git format-patch --cover-letter -s -4 --subject-prefix "PATCH v2" -o my_drivers_patches_v2
* Then I complete the cover letter in my_drivers_patches_v2/0000-cover-letter
* I also reference a small changelog between patchset version and identify the previous cover letter via it's message id
Use the http://lkml.kernel.org service to reference a message-id, i.e this email I answer would be referenced by :
http://lkml.kernel.org/r/1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk
while looking at the email headers at :
Message-Id: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
* Then I look again all the patches and check all the descriptions
* I re-run a checkpatch.pl on all the patches (and ignore errors on the cover letter)
# scripts/checkpatch.pl my_drivers_patches_v2/*
* I identify all the maintainers and mailing lists
# scripts/get_maintainer.pl my_drivers_patches_v2/*
* Personally, I fill the CC: and To: in the headers of each patches, only adding the devicetree mailing list on DT related patches
* Then I send them via git send-email
# git send-email my_drivers_patches_v2/*
=> here you can also select the recipients
=> you can also do a dry run or send yourself the patchset to check before final sending

Another rule is time, please wait at least 1 week after the last review before send another run,
and give yourself more time to check the integrity of the patchset.

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
