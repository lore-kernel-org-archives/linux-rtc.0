Return-Path: <rtc-linux+bncBCEPJZEDQIBBBTU6ZG5QKGQE5IZJEMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ducie-dc1.codethink.co.uk (ducie-dc1.codethink.co.uk. [185.25.241.215])
        by gmr-mx.google.com with ESMTPS id f4si5213wmg.0.2016.06.28.03.19.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 03:19:57 -0700 (PDT)
Subject: [rtc-linux] Re: AMLogic RTC series (second round)
To: Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@lists.codethink.co.uk, rtc-linux@googlegroups.com,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 devicetree@vger.kernel.org
References: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
 <577225A3.9010409@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
 frowand.list@gmail.com
From: Ben Dooks <ben.dooks@codethink.co.uk>
Message-ID: <aea5e2f4-2440-a192-e15a-1f4ff5a30a1c@codethink.co.uk>
Date: Tue, 28 Jun 2016 11:19:47 +0100
MIME-Version: 1.0
In-Reply-To: <577225A3.9010409@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/06/16 08:22, Neil Armstrong wrote:
> On 06/27/2016 06:44 PM, Ben Dooks wrote:
>> Apologies, forgot to put the RTC driver through checkpatch
>> before sending. This gets rid of most of the warnings.
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>
> 
> Hi Ben,
> 
> The patchset looks good but misses some quick introduction on how
> the RTC works, it seems to be connected to an internal serial bus,
> do you have some informations about this ?

I might add a few lines into the rtc-meson.c driver, but that's all
detailed in the datasheet (for once this seems to be documented enough
to be able to function)

> Then, the cover letter of your patchset should contain much more informations
> that "git format-patch --cover-letter" generates.

I may just re-submit once patch to add the RTC and the binding
documentation, and then wait until the reset controller bits have
landed before submitting the

> My personal workflow when I have a set ready is :
> 
> * run checkpatch on C files and check my changes
> # scripts/checkpatch.pl -f path/to/my/driver.c
> * I identify the number of patches to include
> * I generate the patches with cover-letter, signoff and eventually subject-prefix, here for 4 commits
> # git format-patch --cover-letter -s -4 --subject-prefix "PATCH v2" -o my_drivers_patches_v2
> * Then I complete the cover letter in my_drivers_patches_v2/0000-cover-letter
> * I also reference a small changelog between patchset version and identify the previous cover letter via it's message id
> Use the http://lkml.kernel.org service to reference a message-id, i.e this email I answer would be referenced by :
> http://lkml.kernel.org/r/1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk

I keep a copy of sent email anyway, so can get the message-ids out of it.

> while looking at the email headers at :
> Message-Id: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
> * Then I look again all the patches and check all the descriptions
> * I re-run a checkpatch.pl on all the patches (and ignore errors on the cover letter)
> # scripts/checkpatch.pl my_drivers_patches_v2/*
> * I identify all the maintainers and mailing lists
> # scripts/get_maintainer.pl my_drivers_patches_v2/*
> * Personally, I fill the CC: and To: in the headers of each patches, only adding the devicetree mailing list on DT related patches
> * Then I send them via git send-email
> # git send-email my_drivers_patches_v2/*
> => here you can also select the recipients
> => you can also do a dry run or send yourself the patchset to check before final sending

I got sparse and checkpatch confused, and only did sparse on the series.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
