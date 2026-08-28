Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA01440622
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917130; cv=none; b=AcNSr9cR2K114xH9kEe/G2RVgsLvGVfk+YUXYT0hzLd2lr5/Hheqbm//PNIdLFjXzgE03EhrO01BMSIyKZRnKR5aA1AABoaHwCeFiV0Tm22FEtkTBSlHfKe+Ia/dZV5Za4d9ECOLA7uZmbWPlHShJbst0GEW69Aal3v3u5SRhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917130; c=relaxed/simple;
	bh=Yolc/DBb3H0lcmB9LTt9clnWPPbQNHzwg7stvh1CO/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+IQpCNY7w0s2OhEbptFlQl3C1l1DrzLMCvGNBaDh0EtF5OnZ4uVHlL0XDrvy4Gea2fkShD31co1qasaOEmde7N7S4xY80J4GDuMRcz7qK2BX8MDoHgbDXtxEy7vbjbkEiexo7M4+GPkuX9E6D4zLTFw+c+sSazvwKZwSu0PX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cim7Eezp; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cim7Eezp"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6fb956002so12569145ad.1
        for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 04:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787917117; x=1788521917; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yolc/DBb3H0lcmB9LTt9clnWPPbQNHzwg7stvh1CO/g=;
        b=Cim7EezptqYRRqLgpi2gscDTmc5D5L5GW3uzdkqTkKgglm/VMUpwzfndCQpouJSkp6
         5h0sAQ1Ak2JKR6FszUWQiUL3Us8SNqUuGLbaddOmY+MBTr92aAd664RJvSg5x00qmUsJ
         uJoN+A2T/9byn9hXGIdExH/iI1/MSF7hHAqvk8SGbZieT5pWO7vooSHa7l9CQQY+JFCC
         nUHalXY8IpFIHYTS193umK3aNYtNDI548bzsZsU4hl16olCaGyd8q9IJd5zK65sS4FBU
         gV+thcp7UBDrqicet/tXHx8xJqGVBcG1pzy5HCAniTvoZG9rdm7pTqZnIpS+6AT02Ct4
         jpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787917117; x=1788521917;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yolc/DBb3H0lcmB9LTt9clnWPPbQNHzwg7stvh1CO/g=;
        b=cY4K1ScEMVuYcuoSCdoptNrZxzV+heZbsDeNAIGwLovMkdUtD9Kpg/2ieqEF8O08co
         KxpkOIh5EKVGZDqlgXMaLoqyfBqLTHZXRuLZGI78LteCpBtze6Qa7TZtfQ5SwtZcPzdK
         xubTB6/4E6AlsF55qApDL5IyEr2YpSOUw8oc3XS41qRQ0o7ae/cda3VbP8aMPfVEw5l0
         b8EYclbApvKtLHj2+sW3Z0XAprJJ2e2HkXfBoVXDV+tUj7ZCxBHLicVVQPAqSeIHYIrF
         idSCZnYqnQzXeSSFki4pg+cvgjCHikvc9qajmK6ZUj5UbkHw3X/H0NcUjVKcPuNWfHuD
         tkLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+OQb+5Er/ly1VzTUioErb46D4Lunxso24E3GjfZfubaZx51i0vsfOsJhq6RS+37OsGFjCx2N5jyc=@vger.kernel.org
X-Gm-Message-State: AFuF++n9VL0uMAsxeNkKOjoF7kq0qk1Ab8VYKSSVkLllK2I5PqtbBBp+
	mek0k8SlQwvDeru2eD8ocE+NmgbSkdStqI7mNAu5giHlqcFvHoNGC+7W/rOtD1o4vS37qkyKJt1
	9Bg==
X-Received: from pleo10.prod.google.com ([2002:a17:903:210a:b0:2ce:d12d:d6f5])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b08:b0:2ca:e62c:9e96
 with SMTP id d9443c01a7336-2d74dc51c7cmr135512585ad.5.1787917116239; Fri, 28
 Aug 2026 04:38:36 -0700 (PDT)
Date: Fri, 28 Aug 2026 11:38:34 +0000
In-Reply-To: <20260813063503.4023719-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813063503.4023719-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828113834.2354953-1-wakel@google.com>
Subject: Re: [PATCH] selftests: rtc: fix flaky date_read_loop test
From: Wake Liu <wakel@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alexandre,

Since Shuah might be busy and hasn't had a chance to pick up this patch,
would it be possible for you to take it directly through the rtc-next tree?

Original patch & your Acked-by:
https://lore.kernel.org/all/20260430120313.4078185-1-wakel@google.com/

Thanks,
Wake
