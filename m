Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580338B7D1
	for <linux-rtc@vger.kernel.org>; Thu, 13 Aug 2026 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602906; cv=none; b=j4d3bM2HomofPQXxqrf2hsWBnYXEGgoriJZJgV2upOetXHkqu4/VydAL1yWYM/gKaCmH88AXgT0N40xrm3Onrz8ZRZDU9fkirEEuqpTv8O7xH1NHy0gq8x3iVVGBiA1FstsuaIjc7zSvkUGG64pc0uPtPcujrRaMFXzQ6Bw0xtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602906; c=relaxed/simple;
	bh=xQUgyJLWEUo8rNSfcs9RsMhAZwGlUEbBjVggc4DxqJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fzPXDUmf6fQ+CNlAb6VNDGhZJVTx35C93qiSbyqyMvkgjvHJRFAQSa2RPmaj9iPnOL7SzTtlwezwUIzgGvfobpHT4YOFqEbZa7taTTStnS8QoZGCSSSJ/Oc2+mQk2Eug5Q9Y9jTE2Nca8Csy+2dZ7NzPTiOzJtMClKIrtxvR8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMz0yblI; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMz0yblI"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3931cd2e4cbso947750a91.2
        for <linux-rtc@vger.kernel.org>; Wed, 12 Aug 2026 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786602905; x=1787207705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQUgyJLWEUo8rNSfcs9RsMhAZwGlUEbBjVggc4DxqJQ=;
        b=NMz0yblIPKIm7aZMNWEGvWvjp6BBkZZPO5iGXeN7cXvjzVWQ3ZXm+WmIwUsYm+gB2E
         SEU2ybIYUsjOrSKgX9T1zswD5E2ajSFI8VRZYsEGe/pxGMjSMdUqlpeIKMgp+PY+VWIZ
         x1oLgKfOsTU22bqeu345IuZCNzmVT/31ddFqSSwV5jeIF0SCD0Jx50Jr0JhwiCsVMk+L
         UswmGbOnZzrn2HqjVYInsrn0rPpY3TxtVarX/fo8IAbfY04t5fmkole3+4Mv6AifR/53
         CMJlGOUWuwXDRk/3mgBPBWDYVfQuUY4tX0ieZfx/Bk62guETDNZ4xrI6AlDcnNFnxiB9
         Z1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786602905; x=1787207705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQUgyJLWEUo8rNSfcs9RsMhAZwGlUEbBjVggc4DxqJQ=;
        b=DERM61Yw42rgdRNi7Tn9WQ2jHYi1z9keaTbihmMaQ0O9Aljh0WxClbEnK0bKwnqXgz
         ZozFqAtwwcmYKIviIL3vKbd25UouJ+UObiHo12o1SGuU/4htPSMxYATPL/lrGYPToluc
         nWkkfctBIMMZQqHidd4790ySGKTYNmOz1e+jsypdKT8QEimGsL3c08qG+Pmfv5Bfgg7T
         zhtyL9XtAgfJaIAWTjCrHkXX6BezD7290Hs3tDTgZu0t+1HWebEbhu59FWOLKPUMcQGE
         CyIpzJ9NrDYecA09rmJv3hE2fscpNXjWLnf+zsd3MaeBP0lVgmKpV+UTrdMx43KRLSDC
         4WUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/SvANX6wbRe9dMTacEfWBfk8r1xUI7EF1wHpsjyqBykGbFZ71FCKWYmQdgEV2Rp/Zve3qQWQklLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPujgYYrD0oVWYB0CgkM+aG2JKFV6LdghG5prqzVwOCNgyI1A3
	GicBIVVYE6LCCeRWOJTsWrtWYg9f+6E80E7VAZAq+FBZBppYhDcWff/ZvF6gjifA9IwWF22UNjv
	+cQ==
X-Received: from pjbft2.prod.google.com ([2002:a17:90b:f82:b0:381:1eec:b454])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17ca:b0:38e:6bd7:fbbf
 with SMTP id 98e67ed59e1d1-3931e29a12fmr3604505a91.20.1786602904812; Wed, 12
 Aug 2026 23:35:04 -0700 (PDT)
Date: Thu, 13 Aug 2026 06:35:02 +0000
In-Reply-To: <20260615150119ee47a1aa@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615150119ee47a1aa@mail.local>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813063503.4023719-1-wakel@google.com>
Subject: Re: [PATCH] selftests: rtc: fix flaky date_read_loop test
From: Wake Liu <wakel@google.com>
To: Shuah Khan <shuah@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shuah,

A gentle ping on this patch. Alexandre has already provided his Acked-by:
https://lore.kernel.org/linux-kselftest/20260615150119ee47a1aa@mail.local/

Could you please consider picking this up for kselftest/next when you have time?

Thanks,
Wake
