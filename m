Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:43118 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbeGROoo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 10:44:44 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A86F3B00758
        for <linux-rtc@vger.kernel.org>; Wed, 18 Jul 2018 16:06:38 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JOQA19_ie3Vi for <linux-rtc@vger.kernel.org>;
        Wed, 18 Jul 2018 16:06:37 +0200 (CEST)
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
 <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
Date: Wed, 18 Jul 2018 16:06:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Andy,

Il 18/07/2018 14:47, Andy Shevchenko ha scritto:
> On Wed, Jul 18, 2018 at 12:40 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> On m41txx you can enable open-drain OUT pin to check if offset is ok.
>> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
>> 512 times faster than 1s tick base.
>>
>> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
> 
>> +static ssize_t frequency_test_enable_store(struct device *dev,
>> +                                          struct device_attribute *attr,
>> +                                          const char *buf, size_t count)
>> +{
>> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
> 
> 
>> +       bool freq_test_en = 0;
> 
> First of all, initialization of boolean using int is not very best style.
> Second, this is not needed.

Ok I remove initialization.

> 
>> +       int ret;
>> +
>> +       ret = kstrtobool(buf, &freq_test_en);
> 
>> +       if (ret == -EINVAL) {
> 
> What kind of other error code you may expect and why they are not
> considered as no error?

According to documentation, kstrtobool can only fail with -EINVAL.
See:
https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332

> 
>> +               dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
>> +               return ret;
>> +       }
>> +
>> +       regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL, M41TXX_BIT_FT,
>> +                          freq_test_en ? M41TXX_BIT_FT : 0);
>> +
>> +       return count;
>> +}
>> +
>> +static ssize_t frequency_test_enable_show(struct device *dev,
>> +                                         struct device_attribute *attr,
>> +                                         char *buf)
>> +{
>> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
>> +       unsigned int ctrl_reg;
>> +
>> +       regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
>> +
> 
>> +       if (ctrl_reg & M41TXX_BIT_FT)
>> +               return scnprintf(buf, PAGE_SIZE, "on\n");
>> +       else
>> +               return scnprintf(buf, PAGE_SIZE, "off\n");
> 
> Entire condition might be one line.

Right, I change it.

> 
>> +}
>> +
> 
>> +static int ds1307_add_frequency_test(struct ds1307 *ds1307)
>> +{
> 
>> +       int err = 0;
> 
> Redundant assignment. See below.

Ok.

> 
>> +
>> +       switch (ds1307->type) {
>> +       case m41t0:
>> +       case m41t00:
>> +       case m41t11:
>> +               /* Export sysfs entries */
>> +               err = sysfs_create_group(&(ds1307->dev)->kobj,
>> +                                        &rtc_freq_test_attr_group);
>> +               if (err) {
>> +                       dev_err(ds1307->dev,
>> +                               "Failed to create sysfs group: %d\n",
>> +                               err);
>> +                       return err;
>> +               }
>> +
>> +               err = devm_add_action_or_reset(ds1307->dev,
>> +                                              rtc_calib_remove_sysfs_group,
>> +                                              ds1307->dev);
>> +               if (err) {
>> +                       dev_err(ds1307->dev,
>> +                               "Failed to add sysfs cleanup action: %d\n",
>> +                               err);
>> +                       sysfs_remove_group(&(ds1307->dev)->kobj,
>> +                                          &rtc_freq_test_attr_group);
>> +                       return err;
>> +               }
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
> 
>> +       return err;
> 
> return 0;

Ok.

Thanks

Giulio
